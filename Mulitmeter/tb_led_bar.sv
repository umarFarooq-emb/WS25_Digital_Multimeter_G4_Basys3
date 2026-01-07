`timescale 1ns/1ps
`default_nettype none

module tb_ste_led_bar;

  // -------------------------------------------------------
  // Parameters
  // -------------------------------------------------------
  parameter int DATA_W   = 3;
  parameter int LED_NR   = 8;
  parameter logic [DATA_W-1:0] DATA_MAX = 3'h7;

  // -------------------------------------------------------
  // Signals
  // -------------------------------------------------------
  logic clk;
  logic rst_n;
  logic [DATA_W-1:0] din_i;
  logic din_update_i;
  logic clr_i;
  logic [LED_NR-1:0] led_o;

  // -------------------------------------------------------
  // Instantiate DUT
  // -------------------------------------------------------
  ste_led_bar #(
    .DATA_W(DATA_W),
    .DATA_MAX(DATA_MAX),
    .LED_NR(LED_NR)
  ) dut (
    .clk(clk),
    .rst_n(rst_n),
    .din_i(din_i),
    .din_update_i(din_update_i),
    .clr_i(clr_i),
    .led_o(led_o)
  );

  // -------------------------------------------------------
  // Clock generation: 10ns period
  // -------------------------------------------------------
  initial clk = 0;
  always #5 clk = ~clk;

  // -------------------------------------------------------
  // Test procedure
  // -------------------------------------------------------
  initial begin
    // Initialize signals
    rst_n        = 0;
    din_i        = 0;
    din_update_i = 0;
    clr_i        = 0;

    // Apply reset
    #20;
    rst_n = 1;

    // ---------------------------------------------------
    // Test 1: Basic LED bar fill
    // ---------------------------------------------------
    $display("Test 1: Basic LED bar fill");
    apply_input(4'h0);
    apply_input(4'h3);
    apply_input(4'h7);
    apply_input(4'hf);

    // ---------------------------------------------------
    // Test 2: Clear
    // ---------------------------------------------------
    $display("Test 2: Clear LED bar");
    clr_i = 1;
    #10;
    clr_i = 0;

    // ---------------------------------------------------
    // Test 3: Random input sequence
    // ---------------------------------------------------
    $display("Test 3: Random inputs");
    repeat (10) begin
      apply_input($urandom_range(0, DATA_MAX));
    end

    // Finish simulation
    #50;
    $display("Test completed!");
    $finish;
  end

  // -------------------------------------------------------
  // Task to apply input and update LEDs
  // -------------------------------------------------------
  task apply_input(input logic [DATA_W-1:0] value);
    begin
      din_i = value;
      din_update_i = 1;
      #10;
      din_update_i = 0;
      #10;
      $display("Time %0t | din_i=%0h | led_o=%b", $time, din_i, led_o);
    end
  endtask

endmodule

`default_nettype wire
