//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu #(
    parameter n = 32
)(
    input  logic        clock,
    input  logic [n-1:0] a,
    input  logic [n-1:0] b,
    input  logic [2:0]  alucontrol,
    output logic [n-1:0] result,
    output logic        zero
);
    logic [n-1:0] condinvb, sum;
    logic [(2*n-1):0] HiLo;

    assign zero = (result == {n{1'b0}});
    assign condinvb = alucontrol[2] ? ~b : b;
    assign sumSlt = a + condinvb + alucontrol[2];

    initial
        begin
            HiLo = 64'b0;
        end

    always @(a, b, alucontrol) begin
        case (alucontrol)
            3'b000: result = a & b;
            3'b001: result = a | b;
            3'b010: result = a + b;
            3'b011: result = ~(a | b);
            3'b110: result = a - b;
            3'b111: begin
                 if (a[31] != b[31])
                     if (a > b )
                         result = 1;
                     else
                         result = 0;
                 else
                     if (a < b)
                         result = 1;
                     else
                         result = 0;
                 
            end
        endcase
    end

    always @(negedge clock) begin
        case (alucontrol)
            3'b011: HiLo = a * b;
        endcase				
    end

endmodule

`endif // CUSTOM_ALU


endmodule

`endif // ALU
