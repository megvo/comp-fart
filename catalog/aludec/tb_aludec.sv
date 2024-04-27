// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27

`timescale 1ns/100ps

module aludec_tb;

  // Testbench Inputs
  reg [5:0] funct;
  reg [1:0] aluop;

  // Testbench Outputs
  wire [2:0] alucontrol;

  // Instantiate aludec module
  aludec #(.n(32)) dut (
    .funct(funct),
    .aluop(aluop),
    .alucontrol(alucontrol)
  );

  // Testbench Procedure
  initial begin
    // Initialize inputs
    funct = 6'b000000;
    aluop = 2'b00;

    // Wait for a few clock cycles
    #10;

    // Test case 1
    funct = 6'b000011;
    aluop = 2'b10;
    #5; // Wait for output stabilization
    $display("ALU Control: %b", alucontrol);

    // Test case 2
    funct = 6'b000100;
    aluop = 2'b10;
    #5; // Wait for output stabilization
    $display("ALU Control: %b", alucontrol);

    // Test case 3
    funct = 6'b000000;
    aluop = 2'b10;
    #5; // Wait for output stabilization
    $display("ALU Control: %b", alucontrol);

    // ...

    // End simulation
    #100 $finish;
  end

endmodule
