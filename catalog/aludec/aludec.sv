//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: aludec
//     Description: 32-bit RISC ALU decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALUDEC
`define ALUDEC

`timescale 1ns/100ps

module aludec #(
    parameter n = 32
)(
    //
    // --------------- PORT DEFINITIONS ---------------
    //
    input  logic [5:0] funct,
    input  logic [1:0] aluop,
    output logic [2:0] alucontrol
);
    //
    // --------------- MODULE DESIGN IMPLEMENTATION ---------------
    //
    always @* begin
        case (aluop)
            2'b00: alucontrol <= 3'b010;  // Operation for lw/sw/addi
            2'b01: alucontrol <= 3'b110;  // Operation for beq
            2'b11: alucontrol <= 3'b101;  // Operation for bne
            default: begin
                // R-type instruction operations
                case (funct)
                    6'b000011: alucontrol <= 3'b010;  // Operation for add
                    6'b000100: alucontrol <= 3'b110;  // Operation for sub
                    6'b000000: alucontrol <= 3'b000;  // Operation for and
                    6'b000001: alucontrol <= 3'b001;  // Operation for or
                    6'b001100: alucontrol <= 3'b111;  // Operation for slt
                    6'b001001: alucontrol <= 3'b011;  // Operation for mult
                    6'b000010: alucontrol <= 3'b100;  // Operation for nor
                    default: alucontrol <= 3'bxxx;  // Unspecified operation
                endcase
            end
        endcase
    end

endmodule

`endif // CUSTOM_ALUDEC
