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
 
    localparam int WIDTH = 2*DATA_W+BUF_BIT_W;
    localparam int ITERATIONS = WIDTH / 2;
 
    logic [WIDTH-1:0] rad;
    logic [WIDTH-1:0] root;
    logic [WIDTH+1:0] rem;
    logic [5:0] iter;
 
    always_ff @(posedge clk or negedge rst_n) begin
        if (~rst_n || clr) begin
            rad <= '0;
            root <= '0;
            rem <= '0;
            iter <= ITERATIONS + 1;
            dout_o <= '0;
            dout_update_o <= 0;
        end else begin
            dout_update_o <= 0;
            if (din_update_i) begin
                rad <= din_i;
                root <= '0;
                rem <= '0;
                iter <= 0;
            end else if (iter < ITERATIONS) begin
                 logic [WIDTH+1:0] rem_shifted;
                 logic [WIDTH+1:0] test_val;
                 // Bring down the next 2 bits from MSB of rad
                 rem_shifted = (rem << 2) | ((rad >> (WIDTH-2)) & 3);
                 test_val = (root << 2) | 1;
                 if (rem_shifted >= test_val) begin
                     rem <= rem_shifted - test_val;
                     root <= (root << 1) | 1;
                 end else begin
                     rem <= rem_shifted;
                     root <= (root << 1);
                 end
                 rad <= rad << 2;
                 iter <= iter + 1;
            end else if (iter == ITERATIONS) begin
                 dout_o <= root[DATA_W-1:0];
                 dout_update_o <= 1;
                 iter <= iter + 1;
            end
        end
    end
 
endmodule