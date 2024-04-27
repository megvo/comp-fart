////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineers: Lamiah Khan and Megan Vo
// 
// Create Date: 2023-02-07
// Module Name: tb_maindec
// Description: Test bench for simple behavioral main decoder
//
// Revision: 1.0
//
////////////////////////////////////////////////////////////////////////////////

`ifndef TB_MAINDEC
`define TB_MAINDEC

`timescale 1ns/100ps
`include "design.sv"

module tb_maindec;

// Test input signals
reg [5:0] opcode;
reg [5:0] functi;

// Test output signals
wire [1:0] memory_to_register;
wire memory_write;
wire branch, alu_source;
wire [1:0] register_destination;
wire register_write;
wire [1:0] jump_instruction;
wire [1:0] alu_operation;

// Instantiate the maindec module
maindec #(32) dut (
    .opcode(opcode),
    .functi(functi),
    .memory_to_register(memory_to_register),
    .memory_write(memory_write),
    .branch(branch),
    .alu_source(alu_source),
    .register_destination(register_destination),
    .register_write(register_write),
    .jump_instruction(jump_instruction),
    .alu_operation(alu_operation)
);

// Initialize signals
initial begin
    $monitor("opcode=%b functi=%b memory_to_register=%b memory_write=%b branch=%b alu_source=%b register_destination=%b register_write=%b jump_instruction=%b alu_operation=%b",
             opcode, functi, memory_to_register, memory_write, branch, alu_source, register_destination, register_write, jump_instruction, alu_operation);

    // Test case 1: R-type instruction (opcode = 000000, function = 000111)
    #10;
    opcode = 6'b000000;
    functi = 6'b000111;

    // Test case 2: LW instruction (opcode = 000001)
    #10;
    opcode = 6'b000001;
    functi = 6'bxxxxxx;

    // Test case 3: SW instruction (opcode = 000010)
    #10;
    opcode = 6'b000010;
    functi = 6'bxxxxxx;

    // Test case 4: ADDI instruction (opcode = 000011)
    #10;
    opcode = 6'b000011;
    functi = 6'bxxxxxx;

    // Test case 5: SUBI instruction (opcode = 000100)
    #10;
    opcode = 6'b000100;
    functi = 6'bxxxxxx;

    // Test case 6: BEQ instruction (opcode = 000101)
    #10;
    opcode = 6'b000101;
    functi = 6'bxxxxxx;

    // Test case 7: J instruction (opcode = 000111)
    #10;
    opcode = 6'b000111;
    functi = 6'bxxxxxx;

    // Test case 8: Jal instruction (opcode = 001000)
    #10;
    opcode = 6'b001000;
    functi = 6'bxxxxxx;

    // Test case 9: Illegal operation
    #10;
    opcode = 6'b101010;
    functi = 6'bxxxxxx;

    // Test case 10: Jr instruction (function = 001000)
    #10;
    opcode = 6'b000000;
    functi = 6'b000111;

    // Finish simulation
    #10;
    $finish;
end

endmodule
`endif // TB_MAINDEC
