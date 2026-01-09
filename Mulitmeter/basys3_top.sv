`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Klaus Strohmayer
// 
// Create Date:    17:08:26 06/12/2014 
// Design Name: 
// Module Name:    basys3_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
//
// Description: 
//   Multimeter 
//     Read ADC values (1 channel) from PMOD ADC1 (SPI)
//     Calculate RMS and Average Voltage (FIR and IIR average) 
//     Provide the value (selectable) on the 7-Segment display as voltage
//       Channel select with SW15, SW14:
//         00: ADC value
//         01: Average with FIR filter
//         10: RMS Value
//         11: Average with IIR filter
//     Provide the value also as LED level inidicator (1-8 LEDs on)  
//   Send the information to via the UART to the PC (terminal)
     
//     Enable this functionality with SW13
//   Debugging support
//    Muxing out internal signals on JB and JC
//    Add ILA to record the signals from the actual testmux
//    Testmux selection is done with SW1 and SW2
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`default_nettype none
module basys3_top(
  input  wire        clk,       // I; Clock input
  input  wire        btnC,      // I; Center button (reset)

  inout  wire [7:0]  JA,        // IO; PMOD connector A (SPI pins)
  inout  wire [7:0]  JB,        // IO; unused
  inout  wire [7:0]  JC,        // IO; unused

  input  wire [15:0] sw,        // I; switches
  output logic [15:0] led,      // O; LEDs

  // kept for compatibility; tied off in this minimal top
  output logic [6:0] seg,
  output logic [3:0] an,
  output logic      dp,
  output wire       RsTx,
  input  wire       RsRx
);

import mm_pkg::*;

  // -------------------------------------------------------------------------
  // Minimal implementation: instantiate spi_adc and ste_led_bar only
  // -------------------------------------------------------------------------

  // simple active-low reset from center button
  wire rst_n;
  assign rst_n = ~btnC;

  // wires to/from spi_adc
  (* MARK_DEBUG="TRUE" *)wire        data_update_o;
  (* MARK_DEBUG="TRUE" *) wire [11:0] data0_o;
  wire [11:0] data1_o;
  wire        spi_cs_no;
  (* MARK_DEBUG="TRUE" *)wire        spi_sck_o;

  // instantiate spi_adc; always enabled in this minimal top
  spi_adc u_spi_adc (
    .rst_n        (rst_n),
    .clk          (clk),
    .en_i         (1'b1),
    .spi_cs_no    (spi_cs_no),
    .spi_sck_o    (spi_sck_o),
    .spi_miso_i   (JA[2:1]),
    .data_update_o(data_update_o),
    .data0_o      (data0_o),
    .data1_o      (data1_o)
  );

  // Drive PMOD pins for SPI (MISO remain inputs on JA[2:1])
  assign JA[0] = spi_cs_no;
  assign JA[3] = spi_sck_o;

  // instantiate LED bar; feed ADC channel0 directly
  wire [7:0] led_lo;
  ste_led_bar #(
    .DATA_W   (4),
    .DATA_MAX (1'hf),
    .LED_NR   (8)
  ) u_ste_led_bar (
    .clk          (clk),
    .rst_n        (rst_n),
    .din_i        (data0_o),
    .din_update_i (data_update_o),
    .clr_i        (1'b0),
    .led_o        (led_lo)
  );

  // upper LEDs mirror switches
  assign led = {sw[15:8], led_lo};

  // tie off unused ports
  assign RsTx = 1'b1;
  assign seg = 7'b111_1111;
  assign an  = 4'b1111;
  assign dp  = 1'b1;

  // leave JB and JC as high-z at top-level (inout)

endmodule
`default_nettype wire


