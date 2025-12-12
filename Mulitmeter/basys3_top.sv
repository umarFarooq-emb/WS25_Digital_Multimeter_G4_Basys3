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
  input wire   clk           , // I; Clock input (100 MHzz)
	 
  //Push Button Inputs	 
  input  wire          btnC  , // I; Center 
  input  wire          btnU  , // I; Up 
  input  wire          btnD  , // I; Down 
  input  wire          btnR  , // I; Left  
  input  wire          btnL  , // I; Right
	 
  // Pmod Header JA
  inout  wire  [7:0]   JA    , // IO; PMOD connector A 
  inout  wire  [7:0]   JB    , // IO; PMOD connector B  
  inout  wire  [7:0]   JC    , // IO; PMOD connector C  
  
  // USB-RS232 Interface
  output wire          RsTx  , // O; TXD  
  input  wire          RsRx  , // I; RXD
  
  // Switch an LEDs
  input  wire  [15:0]  sw    , // I; SW 0..15 
  output logic [15:0]  led   , // O; LED Outputs 
     
  // Seven Segment Display Outputs
  output logic  [6:0]  seg   , // O; Segment  
  output logic  [3:0]  an    , // O; Anode of Seg0 ..3
  output logic         dp      // O; Anode of decimal point
);
		

  import mm_pkg::*;

  // -------------------------------------------------------------------------
  // Definition
  // -------------------------------------------------------------------------
  // Reset
  logic       rst_n;
  logic [1:0] rst_nff;
  logic       clr_ff;
  
  // Debounced inputs
  logic [7:0] deb_din;
  logic [7:0] deb_dout;
  logic [7:0] deb_dout_pls;
          
  // ADC SPI - Data
  logic        spi_adc_en;
  logic [11:0] spi_adc_data;
  logic        spi_adc_data_update;
    
  // Average
  logic [11:0] avg_fir_data;
  logic        avg_fir_data_update;
  
  // Average via IIR
  logic [11:0] avg_iir_data;
  logic        avg_iir_data_update;
  
  // RMS
  logic [11:0] rms_data;
  logic        rms_data_update;
  
  // Result size:
  //   4 decimal digits 0000 --> 9999
  //   14bit --> 2^14=16384 --> Saturation logic required    
  logic [13:0] result_ff;
  logic        result_update_ff;
    
  result_sel_t result_sel;  
  logic [11:0] result_dout             ; // Selected result 
  logic [15:0] result_dout_bcd         ; // Selected result as BCD 
  logic        result_dout_update      ; // Selected result update
  
  logic [3:9]  dim_val;
  
  // Generation of result string for UART tansfer  
  localparam int CHAR_NR = 13;
  logic [(6      *8)-1:0] char_array_v; 
  logic [(CHAR_NR*8)-1:0] char_array ;
  logic                   char_array_update;
 
  logic                   uart_busy;
  
  // Testmux
                          logic [15:0] test_mux_din  [3:0];
  (* MARK_DEBUG="TRUE" *) logic [1:0]  test_mux_sel;
  (* MARK_DEBUG="TRUE" *) logic [15:0] test_mux_out;


  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  
  // Reset generation
  always @(negedge clk or posedge btnC) begin
    if (btnC) begin
      rst_nff <= 2'b00;
    end else begin
     rst_nff <= {rst_nff[0], 1'b1};
    end  
  end
  assign rst_n = rst_nff[1];
  
  // Handling of all IOs: sync debounce and pulse generation (if required)
  assign deb_din = {sw[15], sw[14], sw[13], sw[2], sw[1], sw[0], btnD, btnU};
  ste_debounce_array #(
    .NBR      (8),
    .SYNC     (8'b11_1_11_111),
    .CNT_W    (4),
    .PLS_RISE (8'b00_0_00_011),
    .PLS_FALL (8'b00_0_00_000)
  ) u_ste_debounce_array(
    .clk       (clk          ), // I; System clock 
    .rst_n     (rst_n        ), // I; active loaw reset 
    .din_i     (deb_din      ), // I; Data in to be debounced
    .deb_rise_i(4'hf         ), // I; maximal count value
    .deb_fall_i(4'hf         ), // I; maximal count value
    .dout_pls_o(deb_dout_pls ), // O; Debounced output pulse 
    .dout_o    (deb_dout     )  // O; Debounced data out
  );
    
  // Clear generation  
  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      clr_ff <= 1'b1;
    end else begin
      clr_ff <= ~deb_dout[DEB_EN];
    end  
  end

  // ADC SPI 
  assign spi_adc_en = ~clr_ff;
  spi_adc u_spi_adc(
    .rst_n  (rst_n),                    // I; Reset (active low)
    .clk    (clk),                      // I; Clock 
  
    // Control
    .en_i    (spi_adc_en),                   // I; Enable

    // SPI interface
    .spi_cs_no    (JA[0]),               // O; SPI chip select
    .spi_sck_o    (JA[3]),               // O; SPI clock
    .spi_miso_i   (JA[2:1]),             // I; SPI data in (2 bit)
  
    // data output 
    .data_update_o (spi_adc_data_update),// O; New data available
    .data0_o       (spi_adc_data       ),// O; ADC data channel 0 
    .data1_o       (             )       // O; ADC data channel 1  
  );
  
  // FIR average filter
  ste_avg_fir #(
    .DATA_W(12)
  ) u_ste_avg (
    .clk             (clk                ), // I; System clock 
    .rst_n           (rst_n              ), // I; system cock reset (active low)  
    .din_i           (spi_adc_data       ), // I; Input data    
    .din_update_i    (spi_adc_data_update), // I; Input data update 
    .avg_clr_i       (clr_ff             ), // I; Clear average data 
    .dout_o          (avg_fir_data       ), // O; Averaged data 
    .dout_update_o   (avg_fir_data_update)  // O; Input data update 
  );
    
  // RMS  
  ste_rms_top #(
    .BUF_BIT_W( 8), 
    .DATA_W   (12)     // 
  ) u_ste_rms_top(
    .clk             (clk                ), // I; System clock 
    .rst_n           (rst_n              ), // I; system cock reset (active low)  
    .din_i           (spi_adc_data       ), // I; Input data    
    .din_update_i    (spi_adc_data_update), // I; Input data update 
    .clr_i           (clr_ff             ), // I; Clear average data 
    .dout_o          (rms_data           ), // O; Averaged data 
    .dout_update_o   (rms_data_update    )  // O; Input data update 
  );
    
  // IIR average Filter   
  ste_avg_iir #(
    .DATA_W      (12)     // _INFO_ Parameter
  ) u_ste_avg_iir (
    .clk             (clk                ), // I; System clock 
    .rst_n           (rst_n              ), // I; system cock reset (active low)  
    .din_i           (spi_adc_data       ), // I; Input data    
    .avg_clr_i       (clr_ff             ), // I; Clear average data 
    .avg_en_i        (spi_adc_data_update), // I; Enable averaging
    .dout_o          (avg_iir_data       ), // O; Averaged data 
    .dout_update_o   (avg_iir_data_update)  // O; Averaged data update
  );

  // Result selection for 7-segment display and UART
  assign result_sel = result_sel_t'({deb_dout[DEB_RES_SEL1], deb_dout[DEB_RES_SEL0]});
  mm_result u_mm_result(
    .clk                  (clk                ), // I; System clock 
    .rst_n                (rst_n              ), // I; system cock reset (active low)  
    .clr_i                (clr_ff             ), // I; Clear  data 
    .din_sel_i            (result_sel         ), // I; Input selection 
    .din_avg_fir_i        (avg_fir_data       ), // I; Input data from FIR filter    
    .din_avg_fir_update_i (avg_fir_data_update), // I; Input data from FIR filter update  
    .din_avg_iir_i        (avg_iir_data       ), // I; Input data from IIR filter    
    .din_avg_iir_update_i (avg_iir_data_update), // I; Input data from IIR filter update    
    .din_rms_i            (rms_data           ), // I; Input data from RMS module   
    .din_rms_update_i     (rms_data_update    ), // I; Input data from RMS module update   
    .din_val_i            (spi_adc_data       ), // I; Input data from ADC    
    .din_val_update_i     (spi_adc_data_update), // I; Input data from ADC update   
    .dout_o               (result_dout        ), // O; Selected result 
    .dout_bcd_o           (result_dout_bcd    ), // O; Selected result as BCD 
    .dout_update_o        (result_dout_update )  // O; Selected result update
  );
  
  
  // Route switch to LEDs
  ste_led_bar #(
    .DATA_W   (3   ), 
    .DATA_MAX (3'h7),
    .LED_NR   (8   )   
  ) u_ste_led_bar(
    .clk             (clk               ), // I; System clock 
    .rst_n           (rst_n             ), // I; system cock reset (active low)  
    .din_i           (result_dout[11:9] ), // I; Input data    
    .din_update_i    (result_dout_update), // I; Input data update 
    .clr_i           (clr_ff            ), // I; Clear  data 
    .led_o           (led[7:0]          )  // O; LEDs drive signal 
  );
  assign led[15:8] = sw[15:8];

  // 7segment display module
  seg7_ctrl u_seg7_ctrl(
    .clk        (clk                      ), // I; System clock 
    .rst_n      (rst_n                    ), // I; system cock reset (active low)  
    .en         (1'b1                     ), // I  1; Enable  
    .dim_up_pls (deb_dout_pls[DEB_DIM_UP ]), // I; Increase brightnes 
    .dim_dwn_pls(deb_dout_pls[DEB_DIM_DWN]), // I; Decrese brightnes 
    .dim_val    (dim_val                  ), // O  4; Actual dimming value     
    .x          (result_dout_bcd          ), // I 16; 
    .x_dp       (4'b1000                  ), // I  4; Display dot 
    .seg        (seg                      ), // O  7; Segments 
    .dp         (dp                       ), // O  1; Segment dot 
    .an         (an                       )  // O  4; Active anode 
  );      


  always_comb begin
    case(result_sel)
      RESULT_SEL_VADC: char_array_v = "Vadc: ";
      RESULT_SEL_VAVG: char_array_v = "Vfir: ";
      RESULT_SEL_VRMS: char_array_v = "Vrms: ";
      RESULT_SEL_VIIR: char_array_v = "Viir: "; 
    endcase
  end
 
  assign char_array = {char_array_v, 
    num2ascii(result_dout_bcd[15:12]), 
    ".",
    num2ascii(result_dout_bcd[11: 8]),
    num2ascii(result_dout_bcd[ 7: 4]),
    num2ascii(result_dout_bcd[ 3: 0]),
     "V", 8'h0d
  };
  
  assign char_array_update = result_dout_update & deb_dout[DEB_UART_EN] & ~uart_busy;
  uart_top #(
    .CHAR_NR  (CHAR_NR) 
  ) u_uart_top (
    .clk                (clk               ), // I; System clock 
    .rst_n              (rst_n             ), // I; system cock reset (active low)  
    .char_array_i       (char_array        ), // I; Array of input chars   
    .char_array_update_i(char_array_update), // I; Array of input chars update 
    .clr_i              (clr_ff            ), // I; Clear average data 
    .busy_o             (uart_busy         ), // O; Transfer busy
    .txd_o              (RsTx              )  // O; Transmit data out 
  );
  
  
  // Testmux -----------------------------------------------------------------
  
  // Assign signals to be muxed out here
  always_comb begin
    test_mux_din[0] = {spi_adc_data_update, 3'b000, spi_adc_data};
    test_mux_din[1] = {spi_adc_data_update, rms_data_update, 2'b00, rms_data};
    test_mux_din[2] = {8'b0000_0000, dim_val};
    test_mux_din[3] = {deb_dout_pls, deb_dout};
  end 
  
  // Test mux
  assign test_mux_sel = {deb_dout[DEB_TMX_SEL1], deb_dout[DEB_TMX_SEL0]};
  assign test_mux_out = test_mux_din[test_mux_sel];  
  assign JB           = test_mux_out[ 7:0];
  assign JC           = test_mux_out[15:0];
    
endmodule
`default_nettype wire 


