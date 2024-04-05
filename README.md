# Execution steps:
- Compile the design and testbench files:
  iverilog -o output pipo.v tb_pipo.v
- Run the simulation:
  vvp output
- View the waveform:
 gtkwave tb_pipo_shift_register.vcd
