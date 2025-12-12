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
// Description       Debouncer array
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       
 
`default_nettype none
module ste_debounce_array #(
  parameter integer        NBR     = 2,
  parameter bit [NBR-1:0]  SYNC    = 2'b11,
  parameter integer        CNT_W   = 4,
  parameter bit [NBR-1:0] PLS_RISE = 2'b00,
  parameter bit [NBR-1:0] PLS_FALL = 2'b00
)(
  input  wire              clk       , // I; System clock 
  input  wire              rst_n     , // I; active low reset 
  input  wire  [NBR-1:0]   din_i     , // I; Data in to be debounced
  input  wire  [CNT_W-1:0] deb_rise_i, // I; maximal count value
  input  wire  [CNT_W-1:0] deb_fall_i, // I; maximal count value
  output logic [NBR-1:0]   dout_pls_o, // O; Debounced data out pulse
  output logic [NBR-1:0]   dout_o      // O; Debounced data out
);
 
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
 
  genvar i;
  generate 
    for (i=0; i<NBR; i++) begin: deb 
      // Debouncer
      ste_debounce #(
        .SYNC  (SYNC[i]),
        .CNT_W (CNT_W  )
      ) u_ste_debounce(
        .clk         (clk       ), // I; System clock 
        .rst_n       (rst_n     ), // I; active low reset 
        .din_i       (din_i[i]  ), // I; Data in to be debounced
        .deb_rise_i  (deb_rise_i), // I; maximal count value
        .deb_fall_i  (deb_fall_i), // I; maximal count value
        .dout_o      (dout_o[i] )  // O; Debounced data out
      );
      
      if (PLS_RISE[i] | PLS_FALL[i]) begin: pls
        // Pulse generation
        ste_edge #(
          .SYNC (0),
          .RISE (PLS_RISE[i]),
          .FALL (PLS_FALL[i]) 
        ) i1_pls(
          .clk            (clk          ), // I; System clock 
          .rst_n          (rst_n        ), // I; system cock reset (active low)  
          .din_i          (dout_o[i]    ), // I; Input data
          .edge_det_o     (dout_pls_o[i])  // O; Edge detected
        );
      end else begin
        assign dout_pls_o[i] = 0;
      end
    end

  endgenerate 

endmodule 
`default_nettype wire

