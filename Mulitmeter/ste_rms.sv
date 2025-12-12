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
// Description       Calculates the RMS value
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
module ste_rms_top #(
  parameter int BUF_BIT_W   =  8, 
  parameter int DATA_W      = 16     // 
) (
  input   wire                clk             , // I; System clock 
  input   wire                rst_n           , // I; system cock reset (active low)  
  input   wire  [DATA_W-1:0]  din_i           , // I; Input data    
  input   wire                din_update_i    , // I; Input data update 
  input   wire                clr_i           , // I; Clear  data 
  output  logic [DATA_W-1:0]  dout_o          , // O; Averaged data 
  output  logic               dout_update_o     // O; Input data update 
);
  
  
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
   assign dout_o        = '0;
   assign dout_update_o = '0;
endmodule
`default_nettype wire  