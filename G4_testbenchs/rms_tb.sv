`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2026 15:00:32
// Design Name: 
// Module Name: rms_tb
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


`timescale 1ns/1ps

module rms_tb;

    // Parameter
    parameter int DATA_W = 16;
    parameter int BUF_BIT_W = 8;

    // Signale
    logic clk;
    logic rst_n;
    logic [DATA_W-1:0] din_i;
    logic din_update_i;
    logic clr_i;
    logic [DATA_W-1:0] dout_o;
    logic dout_update_o;

    // DUT Instanzierung
    ste_rms_top #(
        .BUF_BIT_W(BUF_BIT_W),
        .DATA_W(DATA_W)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .din_i(din_i),
        .din_update_i(din_update_i),
        .clr_i(clr_i),
        .dout_o(dout_o),
        .dout_update_o(dout_update_o)
    );

    // Taktgenerator (10 ns Periode -> 100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initialisierung
        rst_n = 0;
        din_i = 0;
        din_update_i = 0;
        clr_i = 0;

        // Reset aktiv halten
        #6ns;
        rst_n = 1; // Reset loslassen

        // Testdaten einspeisen
        for( int i= 0; i < 100; i++)
        begin
            #10ns;
            din_i = 16'h1015; din_update_i = 1;
            #10ns;
            din_update_i = 0;
        end
        
        for( int i= 0; i < 100; i++)
        begin
            #10ns;
            din_i = 16'h5015; din_update_i = 1;
            #10ns;
            din_update_i = 0;
        end
        
        for( int i= 0; i < 100; i++)
        begin
            #10ns;
            din_i = 16'h006F; din_update_i = 1;
            #10ns;
            din_update_i = 0;
        end
        for( int i= 0; i < 100; i++)
        begin
            #10ns;
            din_i = 16'd50*i; din_update_i = 1;
            #10ns;
            din_update_i = 0;
        end

        // Clear testen
        #20ns;
        clr_i = 1;
        #10ns;
        clr_i = 0;

        for( int i= 0; i < 50; i++)
        begin
            #10ns;
            din_i = 16'h1015; din_update_i = 1;
            #10ns;
            din_update_i = 0;
        end

        // Simulation beenden
        #500ns;
        $stop;
    end

endmodule
