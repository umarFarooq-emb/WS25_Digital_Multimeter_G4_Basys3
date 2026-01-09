module spi_tb();

    logic clk;
    logic reset;
    logic enable;
    logic cs_no;
    logic [11:0] data_o0 = 0;
    logic [11:0] data_o1 = 0;
    logic [1:0] miso;
    logic spi_ck;
    logic data_update;
    
    
initial begin
    clk = 0;
    forever #5 clk = ~clk; //100MHz
end

spi_adc dut(
    .rst_n(reset),               // I; Reset (active low)
    .clk(clk),                // I; Clock 
    // Control
    .en_i(enable),            // I; Enable
    // SPI interface
    .spi_cs_no(cs_no),       // O; SPI chip select
    .spi_sck_o(spi_ck),       // O; SPI clock
    .spi_miso_i(miso),      // I; SPI data in (2 bit)
    // data output 
    .data_update_o(data_update), // O; New data available
    .data0_o(data_o0),       // O; ADC data channel 0 
    .data1_o(data_o1)        // O; ADC data channel 1  
);


//############################################# Helper Task for bit sending and testing
task automatic drive_miso12(input logic [11:0] data);
    logic [15:0] seq;
    integer i;

    // AD7476A format: 4 leading zeros, 12 data bits
    // Example: ABC = 0000_1010_1011_1100
    seq = {4'b0000, data};

    // Wait for CS to go active
    @(negedge cs_no);
    miso[0] = seq[15];

    // Wait for FIRST falling edge of SCK after CS
    // @(negedge spi_ck);

    // Drive bits MSB first on each falling edge window
    for (i = 14; i >= 0; i--) begin
        @(negedge spi_ck);
        miso[0] = seq[i];
    end
endtask
//#############################################


 initial begin
    // Init
    clk = 0;
    reset = 0;
    enable = 0;
    miso = 2'b00;

    // Reset
    #100;
    reset = 1;
    #100;

    // -------------------------------
    // Test 1: ABC
    // Binary: 1010_1011_1100
    // -------------------------------
    enable = 1;
    drive_miso12(12'hABC);
    wait(data_update);
    #50;

    // -------------------------------
    // Test 2: BCD
    // Binary: 1011_1100_1101
    // -------------------------------
    drive_miso12(12'hBCD);
    wait(data_update);
    #50;

    // -------------------------------
    // Test 3: Enable OFF
    // No clocks, no update expected
    // -------------------------------
    enable = 0;
    #2000;

    $display("Test completed - verify waveforms");
    $finish;
end
endmodule