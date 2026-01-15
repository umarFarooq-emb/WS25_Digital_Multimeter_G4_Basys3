`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Klaus Strohmayer 
// 
// Create Date:   
// Design Name: 
// Module Name:    seg7_ctrl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 4 digit 7 segement display controller
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`default_nettype wire
module seg7_ctrl(
  input  wire         rst_n      , // I  1; Asynchronous active low reset
  input  wire         clk        , // I  1; clock 100MHz assumed for correct times 
  input  wire         en         , // I  1; Enable  
  input  wire         dim_up_pls , // I  1; Increase brightnes 
  input  wire         dim_dwn_pls, // I  1; Decrese brightnes 
  output logic [ 3:0] dim_val    , // O  4; Actual dimming value 
  input  wire  [15:0] x          , // I 16; Input BCD value  
  input  wire  [ 3:0] x_dp       , // I  4; Display dot 
  output logic [ 6:0] seg        , // O  7; Segments 
  output logic        dp         , // O  1; Segment dot 
  output logic [ 3:0] an           // O  4; Active anode 
);
	 
  // -------------------------------------------------------------------------
  // Definition of Internal Signals
  // -------------------------------------------------------------------------
  
logic [11:0] refresh_counter;
logic [1:0] led_activate;
logic [3:0] led_number;
logic led_ghosting_cooldown;
logic led_dimming_active;
logic led_dimming;


  // -------------------------------------------------------------------------
  // Implementation 
  // -------------------------------------------------------------------------

// Brightness Control
always_ff @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
      dim_val <= 8;
    end
    else if (dim_up_pls && (dim_val < 15))
    begin
      dim_val <= dim_val + 1; 
    end
    else if (dim_dwn_pls && (dim_val > 0))
    begin
      dim_val <= dim_val - 1;
    end
end

// Digit Multiplexing Control
always_ff @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
    begin
        refresh_counter <= 0;
    end
    else
    begin
        if(en)
        begin
            refresh_counter <= refresh_counter + 1;
        end
    end    
end

assign led_activate = refresh_counter[11:10];
assign led_ghosting_cooldown = refresh_counter[9:5] == 5'b0 || refresh_counter[9:5] == 5'b11111;
assign led_dimming_active = refresh_counter[9:6] > dim_val;

// Active Anode control
always_ff@(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        an <= 4'b1111; 
    end
    else
    begin
        case (led_activate)
            0: an <= 4'b0111; //Activate first digit
            1: an <= 4'b1011; //Activate second digit
            2: an <= 4'b1101; //Activate third digit
            3: an <= 4'b1110; //Activate fourth digit
        endcase
    end
end

// 7 segment display control logic
always_ff@(posedge clk or negedge rst_n)
begin
    if (!rst_n)
    begin
        led_number <= 4'b1111;
        dp <= 1'b1;
    end
    else if (led_dimming_active || led_ghosting_cooldown)
    begin
        led_number <= 4'b1111;
        dp <= 1'b1;
    end
    else
    begin
        if (led_activate == 0)
        begin
            led_number <= x[15:12];
            dp <= ~x_dp[3];
        end
        else if (led_activate == 1)
        begin
            led_number <= x[11:8];
            dp <= ~x_dp[2];
        end
        else if (led_activate == 2)
        begin
            led_number <= x[7:4];
            dp <= ~x_dp[1];
        end
        else
        begin
            led_number <= x[3:0];
            dp <= ~x_dp[0];
        end
    end
end

// 7-Segment Encoding (BCD to 7-segment mapping)
always_comb
begin
    case(led_number)
         4'b0000: seg = 7'b1000000; // "0"  
         4'b0001: seg = 7'b1111001; // "1" 
         4'b0010: seg = 7'b0100100; // "2" 
         4'b0011: seg = 7'b0110000; // "3" 
         4'b0100: seg = 7'b0011001; // "4" 
         4'b0101: seg = 7'b0010010; // "5" 
         4'b0110: seg = 7'b0000010; // "6" 
         4'b0111: seg = 7'b1111000; // "7" 
         4'b1000: seg = 7'b0000000; // "8"  
         4'b1001: seg = 7'b0010000; // "9" 
         default: seg = 7'b1111111; // "OFF"
    endcase
end

endmodule
