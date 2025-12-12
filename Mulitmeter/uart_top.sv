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
// Description       Moving average
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       


// What is the limit in case I do a full calculation over the whole buffer after each sample
`default_nettype none
module uart_top #(
  parameter int CHAR_NR     =  8 
) (
  input   wire                     clk                , // I; System clock 
  input   wire                     rst_n              , // I; system cock reset (active low)  
  input   wire  [(CHAR_NR*8)-1:0]  char_array_i       , // I; Array of input chars   
  input   wire                     char_array_update_i, // I; Array of input chars update 
  input   wire                     clr_i              , // I; Clear average data 
  output  logic                    busy_o             , // O; Transfer busy
  output  logic                    txd_o                // O; Transmit data out 
);
  

  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  

  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  assign busy_o = '0;
  assign txd_o  = '0;
  
  
   
endmodule
`default_nettype wire  