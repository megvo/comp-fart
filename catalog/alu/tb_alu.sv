//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_alu                                                      //
//     Description: Testbench for 32-bit ALU                                    //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////


`include "alu.sv"
`timescale 1ns/100ps

module alu_tb();

  reg clk;
  reg [31:0] a, b;
  reg [2:0] alucontrol;

  wire [31:0] result;
  wire zero;

  alu dut (
    .clk(clk),
    .a(a),
    .b(b),
    .alucontrol(alucontrol),
    .result(result),
    .zero(zero)
  );

  initial begin
    clk = 0;
    a = 32'h00000000;
    b = 32'h00000000;
    alucontrol = 3'b000;
  end

  always #5 clk = ~clk;

  initial begin
    #100;
    a = 32'h0000000B;
    b = 32'h0000000B;
    alucontrol = 3'b111;
    #10;
    $display("Result = %h", result);
    $display("zero = %h", zero);
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
endmodule

