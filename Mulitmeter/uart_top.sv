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
  (* MARK_DEBUG="TRUE" *) output  logic                    txd_o                // O; Transmit data out 
);
  

  // -------------------------------------------------------------------------
  // Definition 
  // -------------------------------------------------------------------------
  //------Real Uart Counter Value
  localparam  MAX_COUNT = 14'd10416; //Takt durch baudrate
  //------Simulation Counter Value
  // localparam  MAX_COUNT = 14'd5; //Takt durch baudrate
  logic [13:0] internal_counter = '0;
  logic [(CHAR_NR*8)-1:0]  char_array_internal;
  int intern_itterater, array_itterater;
  logic [7:0] uart_reg;
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
  
  always_ff @(posedge clk or negedge rst_n) 
  begin
    if (~rst_n || clr_i)
    begin
      char_array_internal <= '0;
      uart_reg  <= '0;
      intern_itterater <= 0;
      array_itterater <= 0;
      txd_o <= 1;
      busy_o <= 0;
    end
    else if(busy_o)
    begin
    //------------------Getakted auf Uart Clock
        if(cnt_uart && array_itterater != CHAR_NR)
        begin
            case (intern_itterater) 
              0 : begin
                  txd_o <= 0; //start bit
                  uart_reg <= char_array_internal[(CHAR_NR*8)-1 : (CHAR_NR-1)*8];
                  char_array_internal <= { char_array_internal[((CHAR_NR-1)*8)-1:0], 8'b0 };
                end
              9 : begin
                    txd_o <= 1; //Stop bit
                    array_itterater <= array_itterater + 1;
                end
              default: begin
                    txd_o <= uart_reg[0];
                    uart_reg <= {1'b0,uart_reg[7:1]};
                end
            endcase
            if (intern_itterater == 9)
            begin
              intern_itterater <= 0;
            end 
            else
            begin
              intern_itterater <= intern_itterater + 1;
            end
        end 
        if(array_itterater == CHAR_NR)
        begin
            busy_o <= 0;
        end 
    end 
    //------------------Getakted auf Uart Clock
    else if(char_array_update_i)
    begin
        char_array_internal <= char_array_i;
        busy_o <= 1;
        array_itterater <= 0;
        intern_itterater <= 0;
        
    end
  end
endmodule
`default_nettype wire 




/*
  always_ff @(posedge clk or negedge rst_n) 
  begin
    if (~rst_n || clr_i)
    begin
      char_array_internal <= '0;
    end
    else if(char_array_update_i && ~busy_o)
    begin
        char_array_internal <= char_array_i;
        busy_o <= 1;
    end
  end
  
  always_ff @(posedge clk or negedge rst_n) 
  begin
    if (~rst_n || clr_i)
    begin
      uart_reg  <= '0;
      intern_itterater <= 0;
      array_itterater <= 0;
      txd_o <= 1;
      busy_o <= 0;
    end
    else if(busy_o && cnt_uart)
    begin
        case (intern_itterater) 
          0 : begin
              txd_o <= 0; //start bit
              uart_reg <= char_array_internal[7:0];
              char_array_internal <= {8'b0, char_array_internal[(CHAR_NR*8)-1:8]};
            end
          9 : begin
                txd_o <= 1; //Stop bit
                array_itterater <= array_itterater + 1;
            end
          default: begin
                txd_o <= uart_reg[0];
                uart_reg <= {1'b0,uart_reg[7:1]};
            end
        endcase
        if(intern_itterater < 9)
        begin
            intern_itterater <= intern_itterater + 1;
        end
        else
        begin
            intern_itterater <= 0;
        end
        if(array_itterater == CHAR_NR-1)
        begin
            busy_o <= 0;
        end 
    end
  end
*/