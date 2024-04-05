`timescale 1ns/1ps

module tb_piso_shift_register;

  // Parameters
  parameter PERIOD = 10; // Clock period in simulation time units

  // Signals
  reg clk;
  reg rst;
  reg [3:0] parallel_in;
  reg shift_en;
  wire serial_out;

  // Instantiate the piso_shift_register module
  piso_shift_register dut (
    .clk(clk),
    .rst(rst),
    .parallel_in(parallel_in),
    .shift_en(shift_en),
    .serial_out(serial_out)
  );

  // Clock generation
  always begin
    #((PERIOD / 2.0)); // Half period delay
    clk <= ~clk;
  end

  // VCD dumping
  initial begin
    $dumpfile("tb_piso_shift_register.vcd");
    $dumpvars(0, tb_piso_shift_register);

    // Initialize signals
    clk = 0;
    rst = 1;
    parallel_in = 4'b0000;
    shift_en = 0;

    // Apply reset
    #5 rst = 0;

    // Testcase 1: Parallel load
    #5 parallel_in = 4'b0100; // Apply parallel input data
    #5 shift_en = 0; // Disable shifting
    #20; // Wait for a few clock cycles
    // serial_out should be equal to the last bit of parallel_in

    // Testcase 2: Shift right
    #5 parallel_in = 4'b1011; // Apply new parallel input data
    #5 shift_en = 1; // Enable shifting
    #20; // Wait for a few clock cycles
    // serial_out should be shifted to the right
    // Add additional delay to allow the shift operation to complete
    #20;

// serial_out should be shifted to the right

    // Add more test cases as needed

    // End simulation
    #10 $finish;
  end

endmodule
