import re
import sys
import threading
import queue
import time
from collections import deque

import serial
import serial.tools.list_ports
import tkinter as tk
from tkinter import ttk, messagebox

import matplotlib
matplotlib.use('TkAgg')
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

# set to True to enable verbose serial/UI prints
DEBUG = False

class SerialReader(threading.Thread):
	def __init__(self, port, baudrate, out_q, stop_event):
		super().__init__(daemon=True)
		self.port = port
		self.baudrate = int(baudrate)
		self.out_q = out_q
		self.stop_event = stop_event
		self.ser = None

	def run(self):
		try:
			self.ser = serial.Serial(self.port, self.baudrate, timeout=1)
		except Exception as e:
			self.out_q.put(('error', f'Open error: {e}'))
			return

		label_re = re.compile(r'(?i)\b(?:vrms|vadc|vfir|viir)[:\s]*([0-9]+\.?[0-9]*)')
		# generic fallback: number followed by V, require non-alnum before/after to avoid matching inside words
		volt_re = re.compile(r'(?<![A-Za-z0-9])([0-9]+\.?[0-9]*)\s*V(?![A-Za-z0-9])', re.IGNORECASE)
		# buffer incoming bytes and parse whenever a 'V' appears
		buf = ''
		while not self.stop_event.is_set():
			try:
				# read any available bytes to avoid waiting for newline
				n = 0
				try:
					n = self.ser.in_waiting
				except Exception:
					n = 0
				if n > 0:
					chunk = self.ser.read(n)
				else:
					chunk = self.ser.read(1)
				if not chunk:
					continue
				try:
					s = chunk.decode('utf-8', errors='ignore')
				except Exception:
					continue
				# sanitize control chars
				s = ''.join(ch if (31 < ord(ch) < 127) else ' ' for ch in s)
				buf += s
				# process complete pieces up to last 'V'
				last_v = buf.rfind('V')
				if last_v == -1:
					# nothing complete yet, continue reading
					continue
				segment = buf[:last_v+1]
				buf = buf[last_v+1:]
				seg = segment.strip()
				# ignore isolated 'V' or very short garbage
				if not seg or seg.lower() == 'v' or len(seg) < 3:
					continue
				# try labeled values first
				found = False
				for m in label_re.finditer(seg):
					try:
						val = float(m.group(1))
						self.out_q.put(('value', val))
						if DEBUG:
							print(f"[serial] parsed labeled value: {val} (from '{seg}')")
						found = True
					except Exception:
						continue
				# fallback to any V-suffixed numbers
				if not found:
					for m2 in volt_re.finditer(seg):
						# extra safety: require that the matched number contains a digit
						num = m2.group(1)
						if not any(ch.isdigit() for ch in num):
							continue
						try:
							val = float(num)
							self.out_q.put(('value', val))
							if DEBUG:
								print(f"[serial] parsed fallback value: {val} (from '{seg}')")
						except Exception:
							continue
				# forward the raw processed segment
				if DEBUG:
					print(f"[serial] raw: {seg}")
				self.out_q.put(('raw', seg))
			except Exception:
				time.sleep(0.05)

		try:
			if self.ser and self.ser.is_open:
				self.ser.close()
		except Exception:
			pass


class App:
	def __init__(self, root):
		self.root = root
		root.title('COM Vrms Live Plot')

		main = ttk.Frame(root, padding=8)
		main.grid(sticky='nsew')

		# Port controls
		ctrl = ttk.Frame(main)
		ctrl.grid(row=0, column=0, sticky='w')

		ttk.Label(ctrl, text='Port:').grid(row=0, column=0, padx=2)
		self.port_cb = ttk.Combobox(ctrl, width=18, state='readonly')
		self.port_cb.grid(row=0, column=1, padx=2)
		ttk.Button(ctrl, text='Refresh', command=self.refresh_ports).grid(row=0, column=2, padx=2)

		ttk.Label(ctrl, text='Baud:').grid(row=0, column=3, padx=8)
		self.baud_cb = ttk.Combobox(ctrl, values=["9600","19200","38400","57600","115200"], width=8)
		self.baud_cb.set('115200')
		self.baud_cb.grid(row=0, column=4, padx=2)

		self.connect_btn = ttk.Button(ctrl, text='Connect', command=self.toggle_connect)
		self.connect_btn.grid(row=0, column=5, padx=8)

		# Value display
		disp = ttk.Frame(main)
		disp.grid(row=1, column=0, sticky='w', pady=(8,0))
		ttk.Label(disp, text='Current Vrms:').grid(row=0, column=0)
		self.val_var = tk.StringVar(value='--')
		tk.Label(disp, textvariable=self.val_var, font=('Consolas', 12, 'bold')).grid(row=0, column=1, padx=8)

		# Raw line display for debugging
		tk.Label(disp, text='Last line:').grid(row=1, column=0, pady=(6,0))
		self.raw_var = tk.StringVar(value='')
		tk.Label(disp, textvariable=self.raw_var, width=60).grid(row=1, column=1, columnspan=4, sticky='w', padx=8)

		# Plot
		fig = Figure(figsize=(6,3), dpi=100)
		self.ax = fig.add_subplot(111)
		self.ax.set_ylim(0, 3.333)
		self.ax.set_xlim(0, 200)
		self.ax.grid(True, which='both', linestyle='--', linewidth=0.5)
		self.ax.set_ylabel('Vrms (V)')
		self.ax.set_xlabel('Samples')
		self.line, = self.ax.plot([], [], lw=1)

		self.canvas = FigureCanvasTkAgg(fig, master=main)
		self.canvas.get_tk_widget().grid(row=2, column=0, pady=8)

		# State
		self.q = queue.Queue()
		self.stop_event = threading.Event()
		self.reader = None
		self.data = deque([0]*200, maxlen=200)

		self.running = False

		self.refresh_ports()
		self.root.after(100, self._poll)

	def refresh_ports(self):
		ports = [p.device for p in serial.tools.list_ports.comports()]
		if not ports:
			ports = ['COM1']
		self.port_cb['values'] = ports
		if not self.port_cb.get() and ports:
			self.port_cb.set(ports[0])

	def toggle_connect(self):
		if not self.running:
			port = self.port_cb.get()
			baud = self.baud_cb.get()
			if not port:
				messagebox.showwarning('No port','Select a COM port first')
				return
			self.stop_event.clear()
			self.reader = SerialReader(port, baud, self.q, self.stop_event)
			self.reader.start()
			self.connect_btn.config(text='Disconnect')
			self.running = True
		else:
			# Signal thread to stop
			self.stop_event.set()
			# attempt to close serial immediately to free the port
			try:
				if self.reader and getattr(self.reader, 'ser', None):
					try:
						self.reader.ser.close()
					except Exception:
						pass
			except Exception:
				pass
			# wait briefly for thread to exit
			try:
				if self.reader:
					self.reader.join(timeout=2)
			except Exception:
				pass
			self.reader = None
			self.connect_btn.config(text='Connect')
			self.running = False

	def _poll(self):
		# Process queue; protect entire poll so exceptions don't stop scheduling
		try:
			updated = False
			processed = 0
			while True:
				try:
					typ, payload = self.q.get_nowait()
				except queue.Empty:
					break
				processed += 1
				if typ == 'value':
					v = payload
					self.data.append(v)
					self.val_var.set(f'{v:.3f} V')
					updated = True
				elif typ == 'raw':
					# update UI raw line but avoid very long console spam
					self.raw_var.set(payload)
					print(f"[ui] raw: {payload}")
				elif typ == 'error':
					messagebox.showerror('Serial error', payload)
					self.stop_event.set()
					self.running = False
					self.connect_btn.config(text='Connect')
					print(f"[ui] serial error: {payload}")
			# end while
		except Exception as e:
			print(f"[ui] poll error: {e}")
			updated = True
			processed = 0
		# update plot once per poll
		if updated:
			y = list(self.data)
			x = list(range(len(y)))
			self.line.set_data(x, y)
			self.ax.set_xlim(max(0, len(y)-200), len(y))
			try:
				self.canvas.draw_idle()
			except Exception as e:
				print(f"[ui] draw error: {e}")

		# reschedule regardless of errors
		self.root.after(100, self._poll)


def main():
	root = tk.Tk()
	root.geometry('760x420')
	app = App(root)
	root.mainloop()


if __name__ == '__main__':
	try:
		main()
	except KeyboardInterrupt:
		sys.exit(0)
