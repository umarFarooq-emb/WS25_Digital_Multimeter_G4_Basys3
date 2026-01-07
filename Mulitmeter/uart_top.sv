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
  parameter MAX_COUNT = 14'd10417; //Takt durch baudrate
  logic [14:0] internal_counter = '0;
  logic [CHAR_NR-1:0] register;
  logic cnt_uart;
  
  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------
  always_ff @(posedge clk or negedge rst_n) 
  begin
    if (!rst_n)
    begin
      internal_counter  <= '0;
      cnt_uart <= 0;
    end
    else if(internal_counter <= MAX_COUNT)
    begin
        internal_counter <= internal_counter +1;
        cnt_uart <= 0;
    end
    else
    begin
        cnt_uart <= 1;
        internal_counter <= '0;
    end
  end
  //was muss noch gemacht werden: transfer of one char und übertrage logik des auslesens des char arrays (= buffer)
  always_ff @(posedge clk or negedge rst_n) 
  begin
    if (!rst_n)
    begin
      register  <= '0;
    end
    else if(cnt_uart)
    begin
        txd_o <= register[0];
        register <= {0,register[CHAR_NR-2:1]};
    end
  end
  
  
   
endmodule
`default_nettype wire  