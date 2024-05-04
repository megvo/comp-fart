//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-04-27
//     Module Name: imem
//     Description: 32-bit RISC memory (instruction "text" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef IMEM
`define IMEM
`timescale 1ns/100ps

module imem (
    input logic [4:0] address,
    output logic [15:0] instruction
    );

    logic [15:0] MEMORY [31:0];

    initial begin
        $readmemh("imem-datafile.dat", MEMORY, 0, 16);
    end

    assign instruction = MEMORY[address];

endmodule

`endif // IMEM
