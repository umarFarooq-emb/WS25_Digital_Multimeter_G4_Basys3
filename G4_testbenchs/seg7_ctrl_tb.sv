`timescale 1ns / 1ps

module tb_seg7_ctrl;

    // Inputs
    reg         rst_n;
    reg         clk;
    reg         en;
    reg         dim_up_pls;
    reg         dim_dwn_pls;
    reg  [15:0] x;
    reg  [3:0]  x_dp;

    // Outputs
    wire [6:0]  seg;
    wire        dp;
    wire [3:0]  an;
    wire [3:0]  dim_val;

    // Instantiate the Unit Under Test (UUT)
    seg7_ctrl uut (
        .rst_n(rst_n),
        .clk(clk),
        .en(en),
        .dim_up_pls(dim_up_pls),
        .dim_dwn_pls(dim_dwn_pls),
        .dim_val(dim_val),
        .x(x),
        .x_dp(x_dp),
        .seg(seg),
        .dp(dp),
        .an(an)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock (10ns period)

    // Test sequence
    initial begin
        // Initialize inputs
        rst_n = 0;
        en = 0;
        dim_up_pls = 0;
        dim_dwn_pls = 0;
        x = 16'h0000;
        x_dp = 4'b0000;

        // Reset the UUT
        #20;
        rst_n = 1;

        // Enable the display
        #10;
        en = 1;

        // Test input value display and dot points
        #10;
        x = 16'h1234; // Set display digits
        x_dp = 4'b1010; // Set dots for digits

        // Test brightness increase
        #50;
        dim_up_pls = 1;
        #10;
        dim_up_pls = 0;

        // Test brightness decrease
        #50;
        dim_dwn_pls = 1;
        #10;
        dim_dwn_pls = 0;

        // Test display transition over time
        #500000;

        // Disable the display
        #10;
        en = 0;

        // Finish simulation
        #100;
        $stop;
    end

endmodule
