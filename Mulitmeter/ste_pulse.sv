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
// Description       Edege detection
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       

// _INFO_ Verilog / SystemVerilog bit falls implicit declaration of wire (assign x = y vs assign x = Y)
`default_nettype none
module ste_edge #(
  parameter bit     SYNC  = 1,
  parameter bit     RISE  = 1,
  parameter bit     FALL  = 0

)(
  input       wire         clk            , // I; System clock 
  input       wire         rst_n          , // I; system cock reset (active low)  
  input       wire         din_i          , // I; Input data
  output      logic        edge_det_o       // O; Edge detected
);
  
  
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  
  // delayed input value  
  logic [1:0]   din_sync_ff;
  logic         din_sync_dly_ff          ; // configuration update



  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

  // Sync handling
  generate 
    if (SYNC) begin
      // Sync
      always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          din_sync_ff  <= 2'b00; 
        end else begin 
          din_sync_ff <= {din_sync_ff[0], din_i}; 
        end  
      end    
    end else begin 
      // No Sync
      assign din_sync_ff = {din_i, 1'b0};         
    end
  
  endgenerate 

  // Pulse delay
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      din_sync_dly_ff  <= 1'b0; 
    end else begin 
      din_sync_dly_ff <= din_sync_ff[1]; 
    end  
  end
  
  // Edege generation
  assign edge_det_o = (( din_sync_ff[1] & (~din_sync_dly_ff)) & RISE) | 
                      ((~din_sync_ff[1] & ( din_sync_dly_ff)) & FALL);
  
endmodule
`default_nettype wire  