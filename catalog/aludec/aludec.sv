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

module aludec
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] funct,
    input  logic [1:0] aluop,
    output logic [2:0] alucontrol);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @*
    begin
        case(aluop)
        2'b00: alucontrol <= 3'b010;  // add (for lw/sw/addi)
        2'b01: alucontrol <= 3'b110;  // beq
        2'b11: alucontrol <= 3'b101;  // bne
        default:
            // for R-type instructions
            case(funct)
                6'b000011: alucontrol <= 3'b010; // add, 3
                6'b000100: alucontrol <= 3'b110; // sub, 4
                6'b000000: alucontrol <= 3'b000; // and, 0
                6'b000001: alucontrol <= 3'b001; // or, 1
                6'b001100: alucontrol <= 3'b111; // slt, 6
                6'b001001: alucontrol <= 3'b011; // mult, 5
                6'b000010: alucontrol <= 3'b100; // nor, 2
                //6'b010000: alucontrol <= 3'b101; // mfhi
                default:   alucontrol <= 3'bxxx; // ???
            endcase
        endcase
    end

endmodule

`endif // ALUDEC
