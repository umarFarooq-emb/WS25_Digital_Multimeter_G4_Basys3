`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Klaus Strohmayer 
// 
// Create Date:   
// Design Name: 
// Module Name:    seg7_ctrl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 4 digit 7 segement display controller
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`default_nettype wire
module seg7_ctrl(
  input  wire         rst_n      , // I  1; Asynchronous active low reset
  input  wire         clk        , // I  1; clock 100MHz assumed for correct times 
  input  wire         en         , // I  1; Enable  
  input  wire         dim_up_pls , // I  1; Increase brightnes 
  input  wire         dim_dwn_pls, // I  1; Decrese brightnes 
  output logic [ 3:0] dim_val    , // O  4; Actual dimming value 
  input  wire  [15:0] x          , // I 16; Input BCD value  
  input  wire  [ 3:0] x_dp       , // I  4; Display dot 
  output logic [ 6:0] seg        , // O  7; Segments 
  output logic        dp         , // O  1; Segment dot 
  output logic [ 3:0] an           // O  4; Active anode 
);
	 
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------

  // -------------------------------------------------------------------------
  // Implementation 
  // -------------------------------------------------------------------------

  
  assign dim_val = '0;
  assign an      = '0;
  assign dp      = '0;
  assign seg     = '0;


endmodule
