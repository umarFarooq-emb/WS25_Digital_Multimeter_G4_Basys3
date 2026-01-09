`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.01.2026 09:49:36
// Design Name: 
// Module Name: ste_avg_iir_tb
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


module ste_avg_iir_tb();
logic [7:0] i;
parameter integer DATA_W      = 16;     // _INFO_ Parameter

logic               clk;
logic               rst_n;
logic [DATA_W-1:0]  din_i;
logic               avg_clr_i;
logic               avg_en_i;
logic [DATA_W-1:0]  dout_o;
logic               dout_update_o; 

  ste_avg_iir #(
    .DATA_W (16)
  ) avg_iir (
    .clk            (clk),                  // I; System clock 
    .rst_n          (rst_n),                // I; system cock reset (active low) 
    .din_i          (din_i),                // I; Input data 
    .avg_clr_i      (avg_clr_i),            // I; Clear average data 
    .avg_en_i       (avg_en_i),            // I; Enable averaging
    .dout_o         (dout_o),               // O; Averaged data
    .dout_update_o  (dout_update_o)         // O; Averaged data update
  );

always #5ns clk = ~clk;

initial
begin
  clk = 0;
  rst_n = 0;
  #20ns;
  
 
  #20ns;
  
//  for (i=0; i< 255; i++)
//  begin
//    avg_en_i = 1;
//    din_i = $urandom_range(4095);
//    #10ns;
    
//    avg_en_i = 0;
//    #10ns;
//  end
din_i=2000;
 rst_n = 1;
avg_en_i = 1;
avg_clr_i = 0;
#10ns;
din_i=0;

#10ns;


  
end

endmodule
