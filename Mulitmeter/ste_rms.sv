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
  logic [BUF_BIT_W-1:0][DATA_W-1:0] shift_reg;
  logic [2*DATA_W+BUF_BIT_W-1:0] mean_square, mean_square_intern;
  int i;
  logic intern_enable, busy;
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  always_ff @(posedge clk or negedge rst_n)
  begin
    if (~rst_n || clr_i)
    begin
        mean_square <= '0;
        mean_square_intern <= '0;
        intern_enable <= 0;
        busy <= 0;
        shift_reg <= '0;
    end
    else
    begin
        if (din_update_i && ~busy)
        begin
            shift_reg <= {shift_reg[BUF_BIT_W-2:0], din_i};
            mean_square <= (shift_reg[0]*shift_reg[0] + 
                            shift_reg[1]*shift_reg[1] + 
                            shift_reg[2]*shift_reg[2] + 
                            shift_reg[3]*shift_reg[3] + 
                            shift_reg[4]*shift_reg[4] + 
                            shift_reg[5]*shift_reg[5] + 
                            shift_reg[6]*shift_reg[6] + 
                            din_i*din_i)/BUF_BIT_W;
        end
        
        if(mean_square == mean_square_intern)
            begin
                intern_enable <= 0;
            end
        else
        begin
            busy <= 1;
            intern_enable <= 1;
            mean_square_intern <= mean_square;
        end
        
        if(dout_update_o == 1)
        begin
            busy <= 0;
        end
    end
 end

    //--------- Calculation of square root 
     square_root #(
        .DATA_W(DATA_W),
        .BUF_BIT_W(BUF_BIT_W)
    ) sqrt_inst (
        .clk(clk),
        .rst_n(rst_n),
        .din_i(mean_square),
        .din_update_i(intern_enable),
        .clr(clr_i),
        .dout_o(dout_o),
        .dout_update_o(dout_update_o)
    );
endmodule
`default_nettype wire  