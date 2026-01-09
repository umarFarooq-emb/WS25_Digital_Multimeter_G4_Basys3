//////////////////////////////////////////////////////////////////////////////////
// Company: FH Joanneum 
// Engineer:  Andreas Heindl
// 
// Create Date: 12/12/2025
// Design Name: 
// Module Name: spi_adc
// Project Name: DCD
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.1 - File Created
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
    output logic        data_update_o, // O; New data available
    output logic [11:0] data0_o,       // O; ADC data channel 0 
    output logic [11:0] data1_o        // O; ADC data channel 1  
);

    // -------------------------------------------------------------------------
    // Variable Declaration
    // -------------------------------------------------------------------------
    
    logic [4:0] sck_count;      //16 cycles counter for sclk needed for 1 readout
    logic [2:0] sck_divider;    //100MHz board, will be split to 16.66MHz
    logic [11:0] data0_shift, data1_shift;   //temp variable that holds not finished shift data
    logic spi_active;
    
    logic edging;   //edge detection for better detection
    wire sck_rise = ( spi_sck_o == 1'b1 && edging == 1'b0 );
    wire sck_fall = ( spi_sck_o == 1'b0 && edging == 1'b1 );
    
    // -------------------------------------------------------------------------
    // Implementation
    // -------------------------------------------------------------------------
    
    // 20MHz clock generation and 16 Counter
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sck_count <= 0;
            data0_shift <= 0;
            spi_active <= 0;
            data1_shift <= 0;
            edging <= 0;
            
            data0_o <= 0;
            data1_o <= 0;
            
            spi_cs_no <= 1;
            data_update_o <= 0;
            spi_sck_o <= 0;
        end//rst
        
        else begin
            data_update_o <= 0;
            edging <= spi_sck_o;//store prev clock
        
            if (en_i) begin
                if (!spi_active) begin//starts a new conversion
                    spi_active <= 1;
                    spi_cs_no <= 0; //activates cs - low
                    sck_count <= 0;
                    spi_sck_o <= 0;
                    sck_divider <= 0;
                    data0_shift <= 0;
                    data1_shift <= 0;
                end//spi active
                
                else begin
                    if (sck_divider == 2) begin //2 => 16.66MHz
                        sck_divider <= 0;
                        spi_sck_o <= ~spi_sck_o;
                    end//clock divider
                    else begin
                        sck_divider <= sck_divider + 1;
                    end
                        
                    //-------RISING SPI EDGE-------
                    if (sck_rise) begin
                        sck_count <= sck_count + 1;
                        
                        // SHIFT DATA RISING EDGE HERE
                        // Simple: always shift, first 4 will be zeros
                        if (sck_count >=1 && sck_count <= 16) begin  // Don't shift after last bit
                            data0_shift <= {data0_shift[10:0], spi_miso_i[0]};
                            data1_shift <= {data1_shift[10:0], spi_miso_i[1]};
                        end//shifting
                    end//rising
                    if (sck_fall) begin
                        if (sck_count == 16) begin
                            // end of conversion
                            spi_active <= 0;
                            spi_cs_no <= 1;
                            spi_sck_o <= 0;
                            data0_o <= data0_shift;
                            data1_o <= data1_shift;
                            data_update_o <= 1;
                        end//me please
                    end//end of falling edge
                end//something
            end//enable
            else begin
                // Not enabled: idle state
                spi_active <= 0;
                spi_cs_no <= 1;
                spi_sck_o <= 0;
            end
        end// data update output cycle 0
    end//always

    
    // Outputs -----------------------------------------------------------------
    //assign data0_o = '0;
    //assign data1_o = '0;
    //assign spi_cs_no = '0;
    //assign spi_sck_o = '0;

  
  
endmodule
`default_nettype wire