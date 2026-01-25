`timescale 1us / 1ns
module top_tb;
reg clk = 0;
always #5 clk = ~clk;
reg btnC = 1; // reset
reg [15:0] sw = 16'b1010000000000001;

wire [7:0] JA;
reg miso = 0;
assign JA[1] = miso;

basys3_top dut (
    .clk(clk),
    .btnC(btnC),
    .btnU(0),
    .btnD(0),
    .btnR(0),
    .btnL(0),
    .JA(JA),
    .JB(),
    .JC(),
    .RsTx(),
    .RsRx(1'b0),
    .sw(sw),
    .led(),
    .seg(),
    .an(),
    .dp()
);

initial begin
    #20; btnC = 0; // release reset
end

// send 12-bit word when CS (JA[0]) falls
reg [11:0] word = 12'h3A0;
integer i;
initial begin
    @(negedge JA[0]);
    for (i = 11; i >= 0; i = i - 1) begin
        @(posedge JA[3]); miso = word[i];
    end
    $display("%0t: sent %h", $time, word);
    #1000; $finish;
end

endmodule

