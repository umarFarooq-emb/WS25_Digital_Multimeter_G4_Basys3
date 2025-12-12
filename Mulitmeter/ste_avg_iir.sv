//  --------------------------------------------------------------------------
//                    Copyright Message
//  --------------------------------------------------------------------------
//
//  CONFIDENTIAL and PROPRIETARY
//  COPYRIGHT (c) XXXX 2019
//
//  All rights are reserved. Reproduction in whole or in part is
//  prohibited without the written consent of the copyright owner.
//
//
//  ----------------------------------------------------------------------------
//                    Design Information
//  ----------------------------------------------------------------------------
//
//  File             $URL: http://.../ste.sv $
//  Author
//  Date             $LastChangedDate: 2019-02-15 08:18:28 +0100 (Fri, 15 Feb 2019) $
//  Last changed by  $LastChangedBy: kstrohma $
//  Version          $Revision: 2472 $
//
// Description       Averaging via IIR (1st order)
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       

`default_nettype none
module ste_avg_iir #(
  parameter integer DATA_W      = 16     // _INFO_ Parameter
) (
  input   wire                clk             , // I; System clock 
  input   wire                rst_n           , // I; system cock reset (active low)  
  input   wire  [DATA_W-1:0]  din_i           , // I; Input data    
  input   wire                avg_clr_i       , // I; Clear average data 
  input   wire                avg_en_i        , // I; Enable averaging
  output  logic [DATA_W-1:0]  dout_o          , // O; Averaged data 
  output  logic               dout_update_o     // O; Averaged data update
);
  
  
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
 
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

 
  assign dout_o         = '0;
  assign dout_update_o  = '0;
  
endmodule
`default_nettype wire  