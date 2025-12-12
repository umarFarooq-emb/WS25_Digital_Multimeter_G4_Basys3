//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2020 03:07:06 PM
// Design Name: 
// Module Name: spi_adc
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

`default_nettype none
module spi_adc(
  input wire  rst_n,               // I; Reset (active low)
  input wire  clk ,                // I; Clock 
  
  // Control
  input wire       en_i,            // I; Enable

  // SPI interface
  output logic     spi_cs_no,       // O; SPI chip select
  output logic     spi_sck_o,       // O; SPI clock
  input wire [1:0] spi_miso_i,      // I; SPI data in (2 bit)
  
  // data output 
  output        logic data_update_o, // O; New data available
  output logic [11:0] data0_o,       // O; ADC data channel 0 
  output logic [11:0] data1_o        // O; ADC data channel 1  
);


  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

 
  // Outputs -----------------------------------------------------------------
  assign data0_o = '0;
  assign data1_o = '0;
  assign spi_cs_no = '0;
  assign spi_sck_o = '0;

  
  
endmodule
`default_nettype wire