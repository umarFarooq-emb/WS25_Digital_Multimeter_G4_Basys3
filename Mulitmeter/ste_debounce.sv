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
// Description       Debouncer
//
//  ----------------------------------------------------------------------------
//                    Revision History (written manually)
//  ----------------------------------------------------------------------------
//
//  Date        Author     Change Description
//  ==========  =========  ========================================================
//  2019-01-09  strohmay   Initial verison       
 
`default_nettype none
module ste_debounce #(
  parameter         SYNC  = 0,
  parameter integer CNT_W = 4
)(
  input   wire              clk       , // I; System clock 
  input   wire              rst_n     , // I; active loaw reset 
  input   wire              din_i     , // I; Data in to be debounced
  input   wire  [CNT_W-1:0] deb_rise_i, // I; maximal count value
  input   wire  [CNT_W-1:0] deb_fall_i, // I; maximal count value
  output  logic             dout_o      // O; Debounced data out
);
 
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  
  // _INFO_ How many FFs will be generated?
  
  // _INFO_ enumurate type used for FSM state variable
  // define FSM states
  typedef enum logic [2:0] {
    ZERO = 3'h0, 
    RISE = 3'h1, 
    ONE  = 3'h2, 
    FALL = 3'h3 
  } fsm_type;
  fsm_type fsm_state_ff, fsm_next_state;

  // Sync FF if SYNC else only wire
  logic [1:0] din_sync_ff;

  // Counter
  logic             deb_dout_ff;     // Actual debounced value  
  logic             deb_dout_set;    //  set
  logic             deb_dout_clr;    //  clr
  
  logic [CNT_W-1:0] deb_cnt_ff;      // Debounce counter
  logic             deb_cnt_rise_ld; //   load rising debounce time
  logic             deb_cnt_fall_ld; //   load falling debounce time
  logic             deb_cnt_en;      //   counter enable
  logic             cnt_zero;        //   is zero
  
  logic [2:0] fsm_state_nr_ff;
  

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
      assign din_sync_ff[1] = din_i;         
    end
  
  endgenerate 

  // FSM control -------------------------------------------------------------
  assign fsm_state_nr_ff = fsm_state_ff;
  
  // _INFO_ sequential part of FSM
  always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      fsm_state_ff       <= ZERO;
    end else begin    
      fsm_state_ff <= fsm_next_state;
    end
  end  

  // _INFO_ Sequential part controlled out of FSM 
  // Debounce counter
  always_ff @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
      deb_dout_ff <= 1'b0;
      deb_cnt_ff  <= {CNT_W{1'b0}};
    end else begin    
      // Debounce out
      if          (deb_dout_clr) begin
        deb_dout_ff <= 1'b0;
      end else if (deb_dout_set) begin
        deb_dout_ff <= 1'b1;
      end
    
      // Debounce counter
      if          (deb_cnt_rise_ld) begin
        deb_cnt_ff <= deb_rise_i; 
      end else if (deb_cnt_fall_ld) begin 
        deb_cnt_ff <= deb_fall_i; 
      end else if (deb_cnt_en) begin
        if (~cnt_zero) begin
          deb_cnt_ff <= deb_cnt_ff - 1'b1; 
        end   
      end     
    end
  end

  assign cnt_zero = (deb_cnt_ff == {CNT_W{1'b0}});
  
  // _INFO_ combinational part of FSM
  always_comb begin
    // _INFO_ Default values for all outputs
    fsm_next_state      = fsm_state_ff;
    deb_cnt_rise_ld     = 1'b0;
    deb_cnt_fall_ld     = 1'b0;
    deb_cnt_en          = 1'b0;
    deb_dout_clr        = 1'b0;
    deb_dout_set        = 1'b0;
    case (fsm_state_ff)
      ZERO: begin
          deb_dout_clr        = 1'b1;
          if (din_sync_ff[1]) begin
            deb_cnt_rise_ld     = 1'b1;
            fsm_next_state      = RISE;
          end
        end  
          
      RISE: begin
          if (din_sync_ff[1]) begin
            deb_cnt_en          = 1'b1;
            if (cnt_zero) begin
              deb_dout_set        = 1'b1;
              fsm_next_state      = ONE;
            end
          end else begin 
            fsm_next_state      = ZERO;
          end
        end

      ONE: begin
          deb_dout_set        = 1'b1;
          if (~din_sync_ff[1]) begin
            deb_cnt_fall_ld     = 1'b1;
            fsm_next_state      = FALL;
          end
        end  
          
      FALL: begin    
          if (~din_sync_ff[1]) begin
            deb_cnt_en          = 1'b1;
            if (cnt_zero) begin
              fsm_next_state      = ZERO;
            end
          end else begin 
            fsm_next_state      = ONE;
          end
        end
    endcase
    
  end      

  // Outputs ------------------------------------------------------------------
  assign dout_o = deb_dout_ff;
  
endmodule 
`default_nettype wire

