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

module pipo_shift_register(
  input wire clk,  // Clock input
  input wire rst,  // Reset input
  input wire [3:0] parallel_in, // 4-bit parallel input
  input wire shift_en, // Shift enable
  output wire [3:0] parallel_out // 4-bit parallel output
);

  wire [3:0] shift_reg; // 4-bit shift register

  // Instantiate the d_flip_flop modules
  d_flip_flop dff0 (.clk(clk), .rst(rst), .d(shift_en ? parallel_in[0] : shift_reg[0]), .q(shift_reg[0]));
  d_flip_flop dff1 (.clk(clk), .rst(rst), .d(shift_en ? parallel_in[1] : shift_reg[1]), .q(shift_reg[1]));
  d_flip_flop dff2 (.clk(clk), .rst(rst), .d(shift_en ? parallel_in[2] : shift_reg[2]), .q(shift_reg[2]));
  d_flip_flop dff3 (.clk(clk), .rst(rst), .d(shift_en ? parallel_in[3] : shift_reg[3]), .q(shift_reg[3]));

  // Assign the parallel output
  assign parallel_out = shift_reg;

endmodule