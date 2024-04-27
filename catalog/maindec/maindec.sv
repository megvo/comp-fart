////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineers: Lamiah Khan and Megan Vo
// 
// Create Date: 2024-07-27
// Module Name: maindec
// Description: 32-bit RISC-based CPU main decoder (MIPS)
//
////////////////////////////////////////////////////////////////////////////////

`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module maindec #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input logic [5:0] opcode,
    input logic [5:0] functi,
    output logic memory_write,
    output logic [1:0] jump_instruction,
    output logic [1:0] memory_to_register, 
    output logic branch, alu_source,
    output logic register_write,
    output logic [1:0] register_destination, 
    output logic [1:0] alu_operation);

//
// ---------------- MODULE DESIGN IMPLEMENTATION ----------------
//
logic [11:0] control_signals; // 9-bit control vector
// Assigning individual control signals based on opcode and function
assign {register_write, register_destination, alu_source, branch, memory_write,
        memory_to_register, jump_instruction, alu_operation} = control_signals;
// Logic to determine control signals based on opcode and function
always @* begin
    case(opcode)
        6'b000000: begin
            if(functi == 6'b000111)
                control_signals <= 12'b000000001000;    // Jr
            else
                control_signals <= 12'b101000000010;    // RTYPE
        end
        6'b000001: control_signals <= 12'b100100010000; // LW
        6'b000010: control_signals <= 12'b000101000000; // SW
        6'b000011: control_signals <= 12'b100100000000; // ADDI
        6'b000100: control_signals <= 12'b100100000000; // SUBI
        6'b000101: control_signals <= 12'b000010000001; // BEQ
        6'b001001: control_signals <= 12'b000010000011; // BNE
        6'b000111: control_signals <= 12'b000000000100; // J
        6'b001000: control_signals <= 12'b110000100100; // Jal
        default:   control_signals <= 12'bxxxxxxxxxxxx; // Illegal operation
    endcase
end

endmodule

`endif // MAINDEC
