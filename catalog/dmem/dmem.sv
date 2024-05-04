//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: dmem
//     Description: 32-bit RISC memory ("data" segment)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DMEM
`define DMEM
`timescale 1ns/100ps

module dmem (
    input logic clk, memWrite,
    input logic [15:0] address, writeData,
    output logic [15:0] readData
    );

    logic [15:0] MEMORY [32767:0];

    assign readData = MEMORY[address[15:1]];

    always @(posedge clk) begin
        if (memWrite) MEMORY[address[15:1]] <= writeData;
    end
endmodule

`endif // DMEM
