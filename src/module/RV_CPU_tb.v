`timescale 1ns / 1ps

`include "RV_CPU.v"
`include "clk_gate.v"

module RV_CPU_tb;

  // Testbench signals
  reg clk;
  reg reset;
  wire [9:0] out;

  // Instantiate the RV_CPU module
  RV_CPU dut (
    .clk(clk),
    .reset(reset),
    .out(out)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Adjust clock period as necessary
  end

  // Test sequence
  initial begin
    reset = 0;
    #50 reset = 1;
    #250 reset = 0;

    #1100;
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
