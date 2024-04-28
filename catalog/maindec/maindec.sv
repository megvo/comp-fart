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

module maindec
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [5:0] op,
    output logic [1:0] memtoreg, 
    output logic       memwrite,
    output logic       branch, alusrc,
    output logic [1:0] regdst, 
    output logic       regwrite,
    output logic [1:0] jump,
    output logic [1:0] aluop,
    input  logic [5:0] funct
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [11:0] controls; // 9-bit control vector

    // controls has 9 logical signals
    assign {regwrite, regdst, alusrc, branch, memwrite,
            memtoreg, jump, aluop} = controls;

    always @* begin
        case(op)
            6'b000000: begin
                if(funct == 6'b000111)
                    controls <= 12'b000000001000;    // Jr
                else
                    controls <= 12'b101000000010;    // RTYPE
            end

            6'b000001: controls <= 12'b100100010000; // LW
            6'b000010: controls <= 12'b000101000000; // SW
            6'b000011: controls <= 12'b100100000000; // ADDI
            6'b000100: controls <= 12'b100100000000; // SUBI
            6'b000101: controls <= 12'b000010000001; // BEQ
            6'b001001: controls <= 12'b000010000011; // BNE
            6'b000111: controls <= 12'b000000000100; // J
            6'b001000: controls <= 12'b110000100100; // Jal
            default:   controls <= 12'bxxxxxxxxxxxx; // illegal operation
        endcase
    end



endmodule

`endif // MAINDEC
