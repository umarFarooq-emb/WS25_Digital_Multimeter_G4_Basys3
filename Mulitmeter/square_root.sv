`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2026 14:43:53
// Design Name: 
// Module Name: square_root
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


module square_root #(
    parameter int DATA_W = 16,
    parameter int BUF_BIT_W = 8
)(
    input  wire               clk,
    input  wire               rst_n,
    input  wire [2*DATA_W+BUF_BIT_W-1:0]  din_i,
    input  wire               din_update_i,
    input  wire               clr,
    output logic [DATA_W-1:0] dout_o,
    output logic              dout_update_o
);

    logic [2*DATA_W+BUF_BIT_W-1:0] x;
    logic [2*DATA_W+BUF_BIT_W-1:0] y;
    
    logic [4:0] iter;

    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n || clr) begin
            x <= 0;
            y <= 0;
            iter <= 0;
            dout_o <= 0;
            dout_update_o <= 0;
        end else if (din_update_i) begin
            x <= din_i;
            y <= din_i >> 1; // initial guess
            iter <= 0;
            dout_update_o <= 0;
        end else if (iter < 16) begin // 8 Iterationen
            if(y != 0)
            begin
                y <= (y + x / y) >> 1;
            end
            iter <= iter + 1;
        end else if (iter == 16) begin
            dout_o <= y;
            dout_update_o <= 1;
            iter <= iter + 1;
        end else
        begin
            dout_update_o <= 0;
        end
    end

endmodule