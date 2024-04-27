// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27

`include "alu.sv"
`timescale 1ns/100ps

module alu_tb();

  // Testbench Inputs
  reg clk;
  reg [(31):0] a, b;
  reg [2:0] alucontrol;

  // Testbench Outputs
  wire [(31):0] result;
  wire zero;

  // Instantiate ALU module
  alu dut (
  .clk(clk),
  .a(a),
  .b(b),
  .alucontrol(alucontrol),
  .result(result),
  .zero(zero)
  );

  // Testbench Procedure
 initial begin
  // Initialize inputs
   clk = 0;
   a = 32'h00000000;
   b = 32'h00000000;
   alucontrol = 3'b000; // Branch (SLT) operation
 end

 always begin
  #5 clk = ~clk;
 end

 initial begin
  // Set up input values for the branch instruction
  #100;
  a = 32'h0000000B;
  b = 32'h0000000B;
  alucontrol = 3'b111;
  #10;
  $display("Result = %h", result);
  $display("zero = %h", zero);
  //$dumpfile("alu.vcd");
  //$dumpvars(result,zero,a,b,alucontrol,clk);
  #10; 
  a = 32'h0000000B;
  b = 32'h0000000A;
  alucontrol = 3'b111;
  #10;
  $display("Result = %h", result);
  $display("zero = %h", zero);
  #10;
    a = 32'h0000000A;
  b = 32'h0000000B;
  alucontrol = 3'b110;
  #10;
  $display("Result = %h", result);
  $display("zero = %h", zero);

  #100 $finish;
 end
  // Modify the input values as necessary for different test cases
 
endmodule
