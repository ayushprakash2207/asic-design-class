`timescale 1ns / 1ps

`include "RV_CPU_Copy.v"
`include "clk_gate.v"

module RV_CPU_tb;

  // Testbench signals
  reg clk;
  reg reset;
  wire [9:0] out;

  // Instantiate the RV_CPU module
  rvmyth uut (
    .CLK(clk),
    .reset(reset),
    .OUT(out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Adjust clock period as necessary
  end

  // Test sequence
  initial begin
    // Initialize inputs
    reset = 1;

    // Apply reset for a few cycles
    #600;
    reset = 0;

    // Simulate for a sufficient time to observe the outputs
    #5000;

    // Finish the simulation
    $finish;
  end

  // Monitor the outputs
  initial begin
    $monitor("Time: %t | OUT: %b", $time, out);
  end

  // Dump waveform data
  initial begin
    $dumpfile("RV_CPU_tb.vcd");  // Name of the dump file
    $dumpvars(0, RV_CPU_tb);     // Dump all variables in the testbench
  end

endmodule
