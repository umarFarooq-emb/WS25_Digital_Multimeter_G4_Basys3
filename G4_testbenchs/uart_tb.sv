`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2026 10:45:40
// Design Name: 
// Module Name: uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_tb;
  // ------------------------------------------------------------------
  // Parameter
  // ------------------------------------------------------------------
  parameter int CHAR_NR = 8;

  // ------------------------------------------------------------------
  // DUT Signale
  // ------------------------------------------------------------------
  logic                   clk;
  logic                   rst_n;
  logic [(CHAR_NR*8)-1:0] char_array_i;
  logic                   char_array_update_i;
  logic                   clr_i;
  logic                   busy_o;
  logic                   txd_o;

  // ------------------------------------------------------------------
  // DUT Instanz
  // ------------------------------------------------------------------
  uart_top #(
    .CHAR_NR(CHAR_NR)
  ) dut (
    .clk                 (clk),
    .rst_n               (rst_n),
    .char_array_i        (char_array_i),
    .char_array_update_i (char_array_update_i),
    .clr_i               (clr_i),
    .busy_o              (busy_o),
    .txd_o               (txd_o)
  );

  // ------------------------------------------------------------------
  // Clock Generator (100 MHz)
  // ------------------------------------------------------------------
  initial clk = 0;
  always #5ns clk = ~clk;

  // ------------------------------------------------------------------
  // Stimulus
  // ------------------------------------------------------------------
  initial begin
    // Defaultwerte
    rst_n               = 0;
    char_array_i        = '0;
    char_array_update_i = 0;
    clr_i               = 0;

    #6ns;
    rst_n = 1;

    #25ns;

    char_array_i = {"H","G","F","E","7","C","B","A"};
    #10ns
    char_array_update_i = 1;
    #10ns;
    char_array_update_i = 0;

    wait (busy_o == 0);

    char_array_i = {"T","H","O","M","A","S","9","9"};
    #10ns
    char_array_update_i = 1;
    #10ns;
    char_array_update_i = 0;
    #150ns;
    clr_i = 1;
    #10ns;
    clr_i = 0;
    #100ns;
    char_array_update_i = 1;
    #10ns;
    char_array_update_i = 0;

    wait (busy_o == 0);

    // Simulation beenden
    $stop;
    end
endmodule
