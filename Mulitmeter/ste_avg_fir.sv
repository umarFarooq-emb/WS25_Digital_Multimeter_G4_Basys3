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
module ste_avg_fir #(
  parameter integer DATA_W      = 16     // _INFO_ Parameter
) (
  input   wire                clk             , // I; System clock 
  input   wire                rst_n           , // I; system cock reset (active low)  
  input   wire  [DATA_W-1:0]  din_i           , // I; Input data    
  input   wire                din_update_i    , // I; Input data update 
  input   wire                avg_clr_i       , // I; Clear average data 
  output  logic [DATA_W-1:0]  dout_o          , // O; Averaged data 
  output  logic               dout_update_o     // O; Input data update 
);
  
  
  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
 logic [4:0] i;
 logic [DATA_W-1:0] fifo[7:0];
 logic [DATA_W+2:0] sum;
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
      always_ff@ (posedge clk) begin
        dout_update_o <= 0;
        if(~rst_n  || avg_clr_i)
        begin
            for (i=0; i<8; i++) fifo[i] = 0;
        end
        else if ( din_update_i ) 
        begin
            fifo <= { fifo[6:0],  din_i };
            sum <= ( fifo[0] + fifo[1] + fifo[2] + fifo[3] + fifo[4] + fifo[5] + fifo[6] + fifo[7]);
            //for (i=0; i<8; i++) sum <= sum + fifo[i];
            
            dout_o <= sum >> 3;
            dout_update_o <= 1;
        end
    end
    
    
  
  //assign dout_o         = '0;
  //assign dout_update_o  = '0;
  
endmodule
`default_nettype wire  
