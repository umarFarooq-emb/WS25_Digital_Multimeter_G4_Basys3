`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.12.2025 10:38:41
// Design Name: 
// Module Name: ste_avg_fir_tb
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


module ste_avg_fir_tb();

logic clk;
logic rst_n;
logic [7:0] i;
logic din_update_i;
logic [15:0] din_i;
logic [15:0]  dout_o; 

  ste_avg_fir #(
    .DATA_W (16)
  ) avg_fir (
    .clk           (clk),                 // I; System clock 
    .rst_n         (rst_n),               // I; active low reset 
    .din_i         (din_i),               // I; Data in
    .din_update_i  (din_update_i),        // I; Data in updated
    .dout_update_o (dout_update_o),       // O; Data out updated
    .dout_o        (dout_o)               // O; Debounced data out
  );



always #5ns clk = ~clk;

initial
begin
  clk = 0;
  rst_n = 0;
  #20ns;
  
  rst_n = 1;
  #20ns;
  
  for (i=0; i< 255; i++)
  begin
    din_update_i = 1;
    din_i = $urandom_range(4095);
    #10ns;
    
    din_update_i = 0;
    #10ns;
  end
      
end
    
endmodule
