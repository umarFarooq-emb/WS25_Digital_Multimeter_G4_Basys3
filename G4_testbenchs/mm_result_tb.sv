`timescale 1ns/1ps

module tb_mm_result;

  // Clock and Reset
  reg clk;
  reg rst_n;
  
  // Inputs to mm_result
  reg clr_i;
  reg [1:0] din_sel_i;
  reg [11:0] din_avg_fir_i;
  reg din_avg_fir_update_i;
  reg [11:0] din_avg_iir_i;
  reg din_avg_iir_update_i;
  reg [11:0] din_rms_i;
  reg din_rms_update_i;
  reg [11:0] din_val_i;
  reg din_val_update_i;

  // Outputs from mm_result
  wire [11:0] dout_o;
  wire [15:0] dout_bcd_o;
  wire dout_update_o;

  // Instantiate the mm_result module
  mm_result uut (
    .clk(clk),
    .rst_n(rst_n),
    .clr_i(clr_i),
    .din_sel_i(din_sel_i),
    .din_avg_fir_i(din_avg_fir_i),
    .din_avg_fir_update_i(din_avg_fir_update_i),
    .din_avg_iir_i(din_avg_iir_i),
    .din_avg_iir_update_i(din_avg_iir_update_i),
    .din_rms_i(din_rms_i),
    .din_rms_update_i(din_rms_update_i),
    .din_val_i(din_val_i),
    .din_val_update_i(din_val_update_i),
    .dout_o(dout_o),
    .dout_bcd_o(dout_bcd_o),
    .dout_update_o(dout_update_o)
  );

  // Clock Generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test Sequence
  initial begin
    // Initialize inputs
    rst_n = 0;
    clr_i = 0;
    din_sel_i = 2'b00;
    din_avg_fir_i = 12'h000;
    din_avg_fir_update_i = 0;
    din_avg_iir_i = 12'h000;
    din_avg_iir_update_i = 0;
    din_rms_i = 12'h000;
    din_rms_update_i = 0;
    din_val_i = 12'h000;
    din_val_update_i = 0;

    // Reset
    #10 rst_n = 1;
    
    //Each 12 digit value is converted to 16 digit at the output
    // Test ADC value display with random 12digits value
    #10 din_val_i = 12'hAAA;
        din_val_update_i = 1;
    #10 din_val_update_i = 0;

    // Test FIR filter value display with random 12digits value
    #10 din_sel_i = 2'b01;
        din_avg_fir_i = 12'hBBB;
        din_avg_fir_update_i = 1;
    #10 din_avg_fir_update_i = 0;

    // Test RMS value display with random 12digits value
    #10 din_sel_i = 2'b10;
        din_rms_i = 12'hCCC;
        din_rms_update_i = 1;
    #10 din_rms_update_i = 0;

    // Test IIR filter value display with random 12digits value
    #10 din_sel_i = 2'b11;
        din_avg_iir_i = 12'hDDD;
        din_avg_iir_update_i = 1;
    #10 din_avg_iir_update_i = 0;

    // Clear and end test
    #10 clr_i = 1;
    #10 clr_i = 0;

    // Finish simulation
    #50 $finish;
  end

  // Monitor the outputs
  initial begin
    $monitor("Time: %0t, dout_o: %h, dout_bcd_o: %h, dout_update_o: %b", 
              $time, dout_o, dout_bcd_o, dout_update_o);
  end

endmodule
