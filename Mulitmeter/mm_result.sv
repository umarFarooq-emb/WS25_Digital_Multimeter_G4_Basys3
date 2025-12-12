
 `default_nettype none
module mm_result (
  input   wire         clk                  , // I; System clock 
  input   wire         rst_n                , // I; system cock reset (active low)  
  input   wire         clr_i                , // I; Clear  data 
  input   wire  [ 1:0] din_sel_i            , // I; Input selection 
  input   wire  [11:0] din_avg_fir_i        , // I; Input data from FIR filter    
  input   wire         din_avg_fir_update_i , // I; Input data from FIR filter update  
  input   wire  [11:0] din_avg_iir_i        , // I; Input data from IIR filter    
  input   wire         din_avg_iir_update_i , // I; Input data from IIR filter update    
  input   wire  [11:0] din_rms_i            , // I; Input data from RMS module   
  input   wire         din_rms_update_i     , // I; Input data from RMS module update   
  input   wire  [11:0] din_val_i            , // I; Input data from ADC    
  input   wire         din_val_update_i     , // I; Input data from ADC update   
  output  logic [11:0] dout_o               , // O; Selected result 
  output  logic [15:0] dout_bcd_o           , // O; Selected result as BCD 
  output  logic        dout_update_o          // O; Selected result update
);

  import mm_pkg::*;

  // -------------------------------------------------------------------------
  // Definition
  // -------------------------------------------------------------------------

 


  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

  
  assign dout_o        = '0;
  assign dout_bcd_o    = '0;
  assign dout_update_o = '0;
  
  
endmodule
`default_nettype wire                                                   