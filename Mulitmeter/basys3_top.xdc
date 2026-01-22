## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

## Switches
set_property PACKAGE_PIN V17 [get_ports {sw[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property PACKAGE_PIN V2 [get_ports {sw[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property PACKAGE_PIN T3 [get_ports {sw[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
set_property PACKAGE_PIN T2 [get_ports {sw[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
set_property PACKAGE_PIN R3 [get_ports {sw[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
set_property PACKAGE_PIN W2 [get_ports {sw[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
set_property PACKAGE_PIN U1 [get_ports {sw[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
set_property PACKAGE_PIN T1 [get_ports {sw[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
set_property PACKAGE_PIN R2 [get_ports {sw[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]


## LEDs
set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property PACKAGE_PIN P3 [get_ports {led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property PACKAGE_PIN N3 [get_ports {led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property PACKAGE_PIN L1 [get_ports {led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]


##7 segment display
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

set_property PACKAGE_PIN V7 [get_ports dp]
set_property IOSTANDARD LVCMOS33 [get_ports dp]

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


##Buttons
set_property PACKAGE_PIN U18 [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]
set_property PACKAGE_PIN T18 [get_ports btnU]
set_property IOSTANDARD LVCMOS33 [get_ports btnU]
set_property PACKAGE_PIN W19 [get_ports btnL]
set_property IOSTANDARD LVCMOS33 [get_ports btnL]
set_property PACKAGE_PIN T17 [get_ports btnR]
set_property IOSTANDARD LVCMOS33 [get_ports btnR]
set_property PACKAGE_PIN U17 [get_ports btnD]
set_property IOSTANDARD LVCMOS33 [get_ports btnD]



#Pmod Header JA
#Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {JA[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[0]}]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {JA[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[1]}]
#Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {JA[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[2]}]
#Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {JA[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[3]}]
#Sch name = JA7
set_property PACKAGE_PIN H1 [get_ports {JA[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]
#Sch name = JA8
set_property PACKAGE_PIN K2 [get_ports {JA[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
#Sch name = JA9
set_property PACKAGE_PIN H2 [get_ports {JA[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
#Sch name = JA10
set_property PACKAGE_PIN G3 [get_ports {JA[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]

#Pmod Header JB
#Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {JB[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[0]}]
#Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {JB[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[1]}]
#Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {JB[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[2]}]
#Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {JB[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[3]}]
#Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {JB[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[4]}]
#Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {JB[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[5]}]
#Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {JB[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[6]}]
#Sch name = JB10
set_property PACKAGE_PIN C16 [get_ports {JB[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JB[7]}]



#Pmod Header JC
#Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {JC[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[0]}]
#Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {JC[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[1]}]
#Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {JC[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[2]}]
#Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {JC[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[3]}]
#Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {JC[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[4]}]
#Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {JC[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[5]}]
#Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {JC[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[6]}]
#Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {JC[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {JC[7]}]


##Pmod Header JXADC
##Sch name = XA1_P
#set_property PACKAGE_PIN J3 [get_ports {JXADC[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[0]}]
##Sch name = XA2_P
#set_property PACKAGE_PIN L3 [get_ports {JXADC[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[1]}]
##Sch name = XA3_P
#set_property PACKAGE_PIN M2 [get_ports {JXADC[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[2]}]
##Sch name = XA4_P
#set_property PACKAGE_PIN N2 [get_ports {JXADC[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[3]}]
##Sch name = XA1_N
#set_property PACKAGE_PIN K3 [get_ports {JXADC[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[4]}]
##Sch name = XA2_N
#set_property PACKAGE_PIN M3 [get_ports {JXADC[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[5]}]
##Sch name = XA3_N
#set_property PACKAGE_PIN M1 [get_ports {JXADC[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[6]}]
##Sch name = XA4_N
#set_property PACKAGE_PIN N1 [get_ports {JXADC[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {JXADC[7]}]



##VGA Connector
#set_property PACKAGE_PIN G19 [get_ports {vgaRed[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
#set_property PACKAGE_PIN H19 [get_ports {vgaRed[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
#set_property PACKAGE_PIN J19 [get_ports {vgaRed[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
#set_property PACKAGE_PIN N19 [get_ports {vgaRed[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]
#set_property PACKAGE_PIN N18 [get_ports {vgaBlue[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
#set_property PACKAGE_PIN L18 [get_ports {vgaBlue[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
#set_property PACKAGE_PIN K18 [get_ports {vgaBlue[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
#set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
#set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
#set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
#set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
#set_property PACKAGE_PIN D17 [get_ports {vgaGreen[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
#set_property PACKAGE_PIN P19 [get_ports Hsync]
#set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
#set_property PACKAGE_PIN R19 [get_ports Vsync]
#set_property IOSTANDARD LVCMOS33 [get_ports Vsync]


#USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports RsRx]
set_property IOSTANDARD LVCMOS33 [get_ports RsRx]
set_property PACKAGE_PIN A18 [get_ports RsTx]
set_property IOSTANDARD LVCMOS33 [get_ports RsTx]


##USB HID (PS/2)
#set_property PACKAGE_PIN C17 [get_ports PS2Clk]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2Clk]
#set_property PULLUP true [get_ports PS2Clk]
#set_property PACKAGE_PIN B17 [get_ports PS2Data]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2Data]
#set_property PULLUP true [get_ports PS2Data]


##Quad SPI Flash
##Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
##STARTUPE2 primitive.
#set_property PACKAGE_PIN D18 [get_ports {QspiDB[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[0]}]
#set_property PACKAGE_PIN D19 [get_ports {QspiDB[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[1]}]
#set_property PACKAGE_PIN G18 [get_ports {QspiDB[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[2]}]
#set_property PACKAGE_PIN F18 [get_ports {QspiDB[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[3]}]
#set_property PACKAGE_PIN K19 [get_ports QspiCSn]
#set_property IOSTANDARD LVCMOS33 [get_ports QspiCSn]






connect_debug_port u_ila_0/probe3 [get_nets [list {test_mux_out[0]} {test_mux_out[1]} {test_mux_out[2]} {test_mux_out[3]} {test_mux_out[4]} {test_mux_out[5]} {test_mux_out[6]} {test_mux_out[7]} {test_mux_out[8]} {test_mux_out[9]} {test_mux_out[10]} {test_mux_out[11]} {test_mux_out[14]} {test_mux_out[15]}]]
connect_debug_port u_ila_0/probe4 [get_nets [list {test_mux_sel[0]} {test_mux_sel[1]}]]

connect_debug_port u_ila_0/probe2 [get_nets [list {char_array[0]} {char_array[1]} {char_array[2]} {char_array[3]} {char_array[4]} {char_array[5]} {char_array[6]} {char_array[7]} {char_array[8]} {char_array[9]} {char_array[10]} {char_array[11]} {char_array[12]} {char_array[13]} {char_array[14]} {char_array[15]} {char_array[16]} {char_array[17]} {char_array[18]} {char_array[19]} {char_array[20]} {char_array[21]} {char_array[22]} {char_array[23]} {char_array[24]} {char_array[25]} {char_array[26]} {char_array[27]} {char_array[28]} {char_array[29]} {char_array[30]} {char_array[31]} {char_array[32]} {char_array[33]} {char_array[34]} {char_array[35]} {char_array[36]} {char_array[37]} {char_array[38]} {char_array[39]} {char_array[40]} {char_array[41]} {char_array[42]} {char_array[43]} {char_array[44]} {char_array[45]} {char_array[46]} {char_array[47]} {char_array[48]} {char_array[49]} {char_array[50]} {char_array[52]} {char_array[53]} {char_array[54]} {char_array[55]} {char_array[56]} {char_array[57]} {char_array[58]} {char_array[59]} {char_array[60]} {char_array[61]} {char_array[62]} {char_array[63]} {char_array[64]} {char_array[65]} {char_array[66]} {char_array[67]} {char_array[68]} {char_array[69]} {char_array[70]} {char_array[71]} {char_array[72]} {char_array[73]} {char_array[74]} {char_array[75]} {char_array[76]} {char_array[77]} {char_array[78]} {char_array[79]} {char_array[80]} {char_array[81]} {char_array[82]} {char_array[83]} {char_array[84]} {char_array[85]} {char_array[86]} {char_array[87]} {char_array[88]} {char_array[89]} {char_array[90]} {char_array[91]} {char_array[92]} {char_array[93]} {char_array[94]} {char_array[95]} {char_array[96]} {char_array[97]} {char_array[98]} {char_array[99]} {char_array[100]} {char_array[101]} {char_array[102]} {char_array[103]}]]









connect_debug_port u_ila_0/probe0 [get_nets [list {u_ste_rms_top/sqrt_inst/y[0]} {u_ste_rms_top/sqrt_inst/y[1]} {u_ste_rms_top/sqrt_inst/y[2]} {u_ste_rms_top/sqrt_inst/y[3]} {u_ste_rms_top/sqrt_inst/y[4]} {u_ste_rms_top/sqrt_inst/y[5]} {u_ste_rms_top/sqrt_inst/y[6]} {u_ste_rms_top/sqrt_inst/y[7]} {u_ste_rms_top/sqrt_inst/y[8]} {u_ste_rms_top/sqrt_inst/y[9]} {u_ste_rms_top/sqrt_inst/y[10]} {u_ste_rms_top/sqrt_inst/y[11]} {u_ste_rms_top/sqrt_inst/y[12]} {u_ste_rms_top/sqrt_inst/y[13]} {u_ste_rms_top/sqrt_inst/y[14]} {u_ste_rms_top/sqrt_inst/y[15]} {u_ste_rms_top/sqrt_inst/y[16]} {u_ste_rms_top/sqrt_inst/y[17]} {u_ste_rms_top/sqrt_inst/y[18]} {u_ste_rms_top/sqrt_inst/y[19]} {u_ste_rms_top/sqrt_inst/y[20]} {u_ste_rms_top/sqrt_inst/y[21]} {u_ste_rms_top/sqrt_inst/y[22]} {u_ste_rms_top/sqrt_inst/y[23]} {u_ste_rms_top/sqrt_inst/y[24]} {u_ste_rms_top/sqrt_inst/y[25]} {u_ste_rms_top/sqrt_inst/y[26]} {u_ste_rms_top/sqrt_inst/y[27]} {u_ste_rms_top/sqrt_inst/y[28]} {u_ste_rms_top/sqrt_inst/y[29]} {u_ste_rms_top/sqrt_inst/y[30]} {u_ste_rms_top/sqrt_inst/y[31]}]]
connect_debug_port u_ila_0/probe2 [get_nets [list {u_ste_rms_top/sqrt_inst/x[0]} {u_ste_rms_top/sqrt_inst/x[1]} {u_ste_rms_top/sqrt_inst/x[2]} {u_ste_rms_top/sqrt_inst/x[3]} {u_ste_rms_top/sqrt_inst/x[4]} {u_ste_rms_top/sqrt_inst/x[5]} {u_ste_rms_top/sqrt_inst/x[6]} {u_ste_rms_top/sqrt_inst/x[7]} {u_ste_rms_top/sqrt_inst/x[8]} {u_ste_rms_top/sqrt_inst/x[9]} {u_ste_rms_top/sqrt_inst/x[10]} {u_ste_rms_top/sqrt_inst/x[11]} {u_ste_rms_top/sqrt_inst/x[12]} {u_ste_rms_top/sqrt_inst/x[13]} {u_ste_rms_top/sqrt_inst/x[14]} {u_ste_rms_top/sqrt_inst/x[15]} {u_ste_rms_top/sqrt_inst/x[16]} {u_ste_rms_top/sqrt_inst/x[17]} {u_ste_rms_top/sqrt_inst/x[18]} {u_ste_rms_top/sqrt_inst/x[19]} {u_ste_rms_top/sqrt_inst/x[20]} {u_ste_rms_top/sqrt_inst/x[21]} {u_ste_rms_top/sqrt_inst/x[22]} {u_ste_rms_top/sqrt_inst/x[23]} {u_ste_rms_top/sqrt_inst/x[24]} {u_ste_rms_top/sqrt_inst/x[25]} {u_ste_rms_top/sqrt_inst/x[26]} {u_ste_rms_top/sqrt_inst/x[27]} {u_ste_rms_top/sqrt_inst/x[28]} {u_ste_rms_top/sqrt_inst/x[29]} {u_ste_rms_top/sqrt_inst/x[30]} {u_ste_rms_top/sqrt_inst/x[31]}]]

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 12 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {rms_data[0]} {rms_data[1]} {rms_data[2]} {rms_data[3]} {rms_data[4]} {rms_data[5]} {rms_data[6]} {rms_data[7]} {rms_data[8]} {rms_data[9]} {rms_data[10]} {rms_data[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 12 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {spi_adc_data[0]} {spi_adc_data[1]} {spi_adc_data[2]} {spi_adc_data[3]} {spi_adc_data[4]} {spi_adc_data[5]} {spi_adc_data[6]} {spi_adc_data[7]} {spi_adc_data[8]} {spi_adc_data[9]} {spi_adc_data[10]} {spi_adc_data[11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 12 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {u_ste_rms_top/shift_reg[0][0]} {u_ste_rms_top/shift_reg[0][1]} {u_ste_rms_top/shift_reg[0][2]} {u_ste_rms_top/shift_reg[0][3]} {u_ste_rms_top/shift_reg[0][4]} {u_ste_rms_top/shift_reg[0][5]} {u_ste_rms_top/shift_reg[0][6]} {u_ste_rms_top/shift_reg[0][7]} {u_ste_rms_top/shift_reg[0][8]} {u_ste_rms_top/shift_reg[0][9]} {u_ste_rms_top/shift_reg[0][10]} {u_ste_rms_top/shift_reg[0][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {u_ste_rms_top/mean_square[0]} {u_ste_rms_top/mean_square[1]} {u_ste_rms_top/mean_square[2]} {u_ste_rms_top/mean_square[3]} {u_ste_rms_top/mean_square[4]} {u_ste_rms_top/mean_square[5]} {u_ste_rms_top/mean_square[6]} {u_ste_rms_top/mean_square[7]} {u_ste_rms_top/mean_square[8]} {u_ste_rms_top/mean_square[9]} {u_ste_rms_top/mean_square[10]} {u_ste_rms_top/mean_square[11]} {u_ste_rms_top/mean_square[12]} {u_ste_rms_top/mean_square[13]} {u_ste_rms_top/mean_square[14]} {u_ste_rms_top/mean_square[15]} {u_ste_rms_top/mean_square[16]} {u_ste_rms_top/mean_square[17]} {u_ste_rms_top/mean_square[18]} {u_ste_rms_top/mean_square[19]} {u_ste_rms_top/mean_square[20]} {u_ste_rms_top/mean_square[21]} {u_ste_rms_top/mean_square[22]} {u_ste_rms_top/mean_square[23]} {u_ste_rms_top/mean_square[24]} {u_ste_rms_top/mean_square[25]} {u_ste_rms_top/mean_square[26]} {u_ste_rms_top/mean_square[27]} {u_ste_rms_top/mean_square[28]} {u_ste_rms_top/mean_square[29]} {u_ste_rms_top/mean_square[30]} {u_ste_rms_top/mean_square[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 32 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {u_ste_rms_top/mean_square_intern[0]} {u_ste_rms_top/mean_square_intern[1]} {u_ste_rms_top/mean_square_intern[2]} {u_ste_rms_top/mean_square_intern[3]} {u_ste_rms_top/mean_square_intern[4]} {u_ste_rms_top/mean_square_intern[5]} {u_ste_rms_top/mean_square_intern[6]} {u_ste_rms_top/mean_square_intern[7]} {u_ste_rms_top/mean_square_intern[8]} {u_ste_rms_top/mean_square_intern[9]} {u_ste_rms_top/mean_square_intern[10]} {u_ste_rms_top/mean_square_intern[11]} {u_ste_rms_top/mean_square_intern[12]} {u_ste_rms_top/mean_square_intern[13]} {u_ste_rms_top/mean_square_intern[14]} {u_ste_rms_top/mean_square_intern[15]} {u_ste_rms_top/mean_square_intern[16]} {u_ste_rms_top/mean_square_intern[17]} {u_ste_rms_top/mean_square_intern[18]} {u_ste_rms_top/mean_square_intern[19]} {u_ste_rms_top/mean_square_intern[20]} {u_ste_rms_top/mean_square_intern[21]} {u_ste_rms_top/mean_square_intern[22]} {u_ste_rms_top/mean_square_intern[23]} {u_ste_rms_top/mean_square_intern[24]} {u_ste_rms_top/mean_square_intern[25]} {u_ste_rms_top/mean_square_intern[26]} {u_ste_rms_top/mean_square_intern[27]} {u_ste_rms_top/mean_square_intern[28]} {u_ste_rms_top/mean_square_intern[29]} {u_ste_rms_top/mean_square_intern[30]} {u_ste_rms_top/mean_square_intern[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 12 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {u_ste_rms_top/shift_reg[2][0]} {u_ste_rms_top/shift_reg[2][1]} {u_ste_rms_top/shift_reg[2][2]} {u_ste_rms_top/shift_reg[2][3]} {u_ste_rms_top/shift_reg[2][4]} {u_ste_rms_top/shift_reg[2][5]} {u_ste_rms_top/shift_reg[2][6]} {u_ste_rms_top/shift_reg[2][7]} {u_ste_rms_top/shift_reg[2][8]} {u_ste_rms_top/shift_reg[2][9]} {u_ste_rms_top/shift_reg[2][10]} {u_ste_rms_top/shift_reg[2][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 12 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {u_ste_rms_top/shift_reg[1][0]} {u_ste_rms_top/shift_reg[1][1]} {u_ste_rms_top/shift_reg[1][2]} {u_ste_rms_top/shift_reg[1][3]} {u_ste_rms_top/shift_reg[1][4]} {u_ste_rms_top/shift_reg[1][5]} {u_ste_rms_top/shift_reg[1][6]} {u_ste_rms_top/shift_reg[1][7]} {u_ste_rms_top/shift_reg[1][8]} {u_ste_rms_top/shift_reg[1][9]} {u_ste_rms_top/shift_reg[1][10]} {u_ste_rms_top/shift_reg[1][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 12 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {u_ste_rms_top/shift_reg[3][0]} {u_ste_rms_top/shift_reg[3][1]} {u_ste_rms_top/shift_reg[3][2]} {u_ste_rms_top/shift_reg[3][3]} {u_ste_rms_top/shift_reg[3][4]} {u_ste_rms_top/shift_reg[3][5]} {u_ste_rms_top/shift_reg[3][6]} {u_ste_rms_top/shift_reg[3][7]} {u_ste_rms_top/shift_reg[3][8]} {u_ste_rms_top/shift_reg[3][9]} {u_ste_rms_top/shift_reg[3][10]} {u_ste_rms_top/shift_reg[3][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 12 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {u_ste_rms_top/shift_reg[4][0]} {u_ste_rms_top/shift_reg[4][1]} {u_ste_rms_top/shift_reg[4][2]} {u_ste_rms_top/shift_reg[4][3]} {u_ste_rms_top/shift_reg[4][4]} {u_ste_rms_top/shift_reg[4][5]} {u_ste_rms_top/shift_reg[4][6]} {u_ste_rms_top/shift_reg[4][7]} {u_ste_rms_top/shift_reg[4][8]} {u_ste_rms_top/shift_reg[4][9]} {u_ste_rms_top/shift_reg[4][10]} {u_ste_rms_top/shift_reg[4][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 12 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {u_ste_rms_top/shift_reg[5][0]} {u_ste_rms_top/shift_reg[5][1]} {u_ste_rms_top/shift_reg[5][2]} {u_ste_rms_top/shift_reg[5][3]} {u_ste_rms_top/shift_reg[5][4]} {u_ste_rms_top/shift_reg[5][5]} {u_ste_rms_top/shift_reg[5][6]} {u_ste_rms_top/shift_reg[5][7]} {u_ste_rms_top/shift_reg[5][8]} {u_ste_rms_top/shift_reg[5][9]} {u_ste_rms_top/shift_reg[5][10]} {u_ste_rms_top/shift_reg[5][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 12 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {u_ste_rms_top/shift_reg[7][0]} {u_ste_rms_top/shift_reg[7][1]} {u_ste_rms_top/shift_reg[7][2]} {u_ste_rms_top/shift_reg[7][3]} {u_ste_rms_top/shift_reg[7][4]} {u_ste_rms_top/shift_reg[7][5]} {u_ste_rms_top/shift_reg[7][6]} {u_ste_rms_top/shift_reg[7][7]} {u_ste_rms_top/shift_reg[7][8]} {u_ste_rms_top/shift_reg[7][9]} {u_ste_rms_top/shift_reg[7][10]} {u_ste_rms_top/shift_reg[7][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 12 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {u_ste_rms_top/shift_reg[6][0]} {u_ste_rms_top/shift_reg[6][1]} {u_ste_rms_top/shift_reg[6][2]} {u_ste_rms_top/shift_reg[6][3]} {u_ste_rms_top/shift_reg[6][4]} {u_ste_rms_top/shift_reg[6][5]} {u_ste_rms_top/shift_reg[6][6]} {u_ste_rms_top/shift_reg[6][7]} {u_ste_rms_top/shift_reg[6][8]} {u_ste_rms_top/shift_reg[6][9]} {u_ste_rms_top/shift_reg[6][10]} {u_ste_rms_top/shift_reg[6][11]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list u_ste_rms_top/busy]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list u_ste_rms_top/intern_enable]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list result_dout_update]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list rms_data_update]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list spi_adc_data_update]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list u_uart_top/txd_o]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list uart_busy]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_IBUF_BUFG]
