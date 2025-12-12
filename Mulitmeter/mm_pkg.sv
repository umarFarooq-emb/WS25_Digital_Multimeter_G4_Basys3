//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Klaus Strohmayer
// 
// Create Date:    17:08:26 06/12/2014 
// Design Name: 
// Module Name:    basys3_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
//
// Description: 
//   General definittions for the multimeter
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////


`default_nettype none                                                   
package mm_pkg;


  // Input selection
  localparam  DEB_DIM_UP   = 0; // BTNU - Dimming up
  localparam  DEB_DIM_DWN  = 1; // BTND - Dimming down
  localparam  DEB_EN       = 2; // SW00 - Enable
  localparam  DEB_TMX_SEL0 = 3; // SW01 - Testmux selection 0
  localparam  DEB_TMX_SEL1 = 4; // SW02 - Testmux selection 1
  localparam  DEB_UART_EN  = 5; // SW13 - Enable UART TX
  localparam  DEB_RES_SEL0 = 6; // SW14 - Result selection 0    
  localparam  DEB_RES_SEL1 = 7; // SW15 - Result selection 1
  


  // Result selection based on a switch settings
  typedef enum logic [1:0] {
    RESULT_SEL_VADC = 2'h0,
    RESULT_SEL_VAVG = 2'h1,
    RESULT_SEL_VRMS = 2'h2,
    RESULT_SEL_VIIR = 2'h3
  } result_sel_t;
  
  
  
  // Convert a number (0..9) to an ASCII character
  function automatic logic [7:0] num2ascii (input logic [3:0] nbr);
    case (nbr)
      4'h0:    return 8'h30;
      4'h1:    return 8'h31;
      4'h2:    return 8'h32;
      4'h3:    return 8'h33;
      4'h4:    return 8'h34;
      4'h5:    return 8'h35;
      4'h6:    return 8'h36;
      4'h7:    return 8'h37;
      4'h8:    return 8'h38;
      4'h9:    return 8'h39;
      4'hf:    return 8'h0d;
      default: return 8'h3f;
    endcase
  endfunction
  

endpackage
`default_nettype wire                                                   