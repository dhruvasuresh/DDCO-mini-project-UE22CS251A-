module d_flip_flop(
  input wire clk,  // Clock input
  input wire rst,  // Reset input
  input wire d,    // Data input
  output reg q     // Output
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset the flip-flop
      q <= 1'b0;
    end else begin
      // Positive-edge triggered flip-flop behavior
      q <= d;
    end
  end
endmodule

module piso_shift_register(
  input wire clk,          // Clock input
  input wire rst,          // Reset input
  input wire [3:0] parallel_in,  // 4-bit parallel input
  input wire shift_en,     // Shift enable input
  output wire serial_out   // Serial output
);

  reg [3:0] shift_reg;   // 4-bit shift register
  wire [3:0] d_flip_flop_outputs; // Temp variable to store flip-flop outputs

  // Instantiate the d_flip_flop modules
  d_flip_flop dff0 (.clk(clk), .rst(rst), .d(parallel_in[0]), .q(d_flip_flop_outputs[0]));
  d_flip_flop dff1 (.clk(clk), .rst(rst), .d(shift_en ? d_flip_flop_outputs[0] : parallel_in[1]), .q(d_flip_flop_outputs[1]));
  d_flip_flop dff2 (.clk(clk), .rst(rst), .d(shift_en ? d_flip_flop_outputs[1] : parallel_in[2]), .q(d_flip_flop_outputs[2]));
  d_flip_flop dff3 (.clk(clk), .rst(rst), .d(shift_en ? d_flip_flop_outputs[2] : parallel_in[3]), .q(d_flip_flop_outputs[3]));

  // Output assignment
  assign serial_out = shift_en ? d_flip_flop_outputs[3] : parallel_in[3];

  // Shift operation in non-blocking assignments
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset the shift register
      shift_reg <= 4'b0000;
    end else if (shift_en) begin
      // Shift operation
      shift_reg <= {shift_reg[2:0], parallel_in[3]};
    end
  end

endmodule