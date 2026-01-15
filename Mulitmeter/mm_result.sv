`default_nettype none
module mm_result (
  input   wire         clk                  , // I; System clock 
  input   wire         rst_n                , // I; system reset (active low)  
  input   wire         clr_i                , // I; Clear data 
  input   wire  [ 1:0] din_sel_i            , // I; Input selection 
  input   wire  [11:0] din_avg_fir_i        , // I; Input data from FIR filter    
  input   wire         din_avg_fir_update_i , // I; Input data from FIR filter update  
  input   wire  [11:0] din_avg_iir_i        , // I; Input data from IIR filter    
  input   wire         din_avg_iir_update_i , // I; Input data from IIR filter update    
  input   wire  [11:0] din_rms_i            , // I; Input data from RMS module   
  input   wire         din_rms_update_i     , // I; Input data from RMS module update   
  input   wire  [11:0] din_val_i            , // I; Input data from ADC    
  input   wire         din_val_update_i     , // I; Input data from ADC update   
  output  logic [11:0] dout_o               , // O; Selected result 
  output  logic [15:0] dout_bcd_o           , // O; Selected result as BCD 
  output  logic        dout_update_o        // O; Selected result update
);

  // -------------------------------------------------------------------------
  // Definition
  // -------------------------------------------------------------------------

  logic [11:0] selected_data;
  logic [20:0] selected_data_multiplied;
  logic [11:0] selected_data_scaled;
  logic  [2:0] data_update_internal;
  logic [19:0] bcd_data;

  // Internal BCD Conversion Logic
  logic [3:0] thousands;
  logic [3:0] hundreds;
  logic [3:0] tens;
  logic [3:0] units;

  // -------------------------------------------------------------------------
  // Implementation
  // -------------------------------------------------------------------------

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      selected_data <= 12'h000;
      selected_data_multiplied <= 20'h000;
      data_update_internal[0] <= 1'b0;
    end else if (clr_i) begin
      selected_data <= 12'h000;
      selected_data_multiplied <= 20'h000;
      data_update_internal[0] <= 1'b0;
    end else begin
    
      // Select data based on din_sel_i
      case (din_sel_i)
        2'b00: begin        //logic 00: ADC value
        //If both switches are off (00), the ADC value is displayed.
          if (din_val_update_i) begin
            selected_data <= din_val_i;
            selected_data_multiplied <= din_val_i * 20'd220;
            data_update_internal[0] <= 1'b1;
          end else begin
            data_update_internal[0] <= 1'b0;
          end
        end
        2'b01: begin        //logic 01: Average with FIR filter
        //If the first switch is on and the second is off (01), the FIR filter value is displayed.
          if (din_avg_fir_update_i) begin
            selected_data <= din_avg_fir_i;
            selected_data_multiplied <= din_avg_fir_i * 20'd220;
            data_update_internal[0] <= 1'b1;
          end else begin
            data_update_internal[0] <= 1'b0;
          end
        end
        2'b10: begin        //logic 10: RMS Value
        //If the first switch is off and the second is on (10), the RMS value is displayed.
          if (din_rms_update_i) begin
            selected_data <= din_rms_i;
            selected_data_multiplied <= din_rms_i * 20'd220;
            data_update_internal[0] <= 1'b1;
          end else begin
            data_update_internal[0] <= 1'b0;
          end
        end
        2'b11: begin        //logic 11: Average with IIR filter
        //If both switches are on (11), the IIR filter value is displayed.
          if (din_avg_iir_update_i) begin
            selected_data <= din_avg_iir_i;
            selected_data_multiplied <= din_avg_iir_i * 20'd220;
            data_update_internal[0] <= 1'b1;
          end else begin
            data_update_internal[0] <= 1'b0;
          end
        end
        default: begin
          selected_data <= 12'b0;
          selected_data_multiplied <= 20'h000;
          data_update_internal[0] <= 1'b0;
        end
      endcase
    end
  end
  
  always_ff@(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
        selected_data_scaled <= 12'b0;
        data_update_internal[1] <= 1'b0;
  end else begin
    if (data_update_internal[0]) begin
        selected_data_scaled <= selected_data_multiplied / 273;
        data_update_internal[1] <= 1'b1;
    end else begin
        data_update_internal[1] <= 1'b0;
    end
  end
  end
  
  
  always_ff@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        thousands <= 4'b0;
        hundreds <= 4'b0;
        tens <= 4'b0;
        units <= 4'b0;
        dout_update_o <= 1'b0;
    end else if (data_update_internal[1]) begin
        thousands <= (selected_data_scaled / 1000) % 10;
        hundreds  <= (selected_data_scaled / 100) % 10;
        tens      <= (selected_data_scaled / 10) % 10;
        units     <= selected_data_scaled % 10;
        dout_update_o <= 1'b1;
    end else begin
        dout_update_o <= 1'b0;
    end
end

assign dout_bcd_o = {thousands, hundreds, tens, units};

assign dout_o = selected_data;

endmodule
`default_nettype wire