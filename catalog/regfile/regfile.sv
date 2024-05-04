//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: regfile
//     Description: 32-bit RISC register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef REGFILE
`define REGFILE
`timescale 1ns/100ps

module regfile (
    input logic [3:0] readAddr1, readAddr2, writeAddr,
    input logic [15:0] writeData,
    input logic regWrite, clk,
    output logic [15:0] readData1, readData2
    );

    reg [15:0] rFile [15:0];
    assign readData1 = rFile[readAddr1];
    assign readData2 = rFile[readAddr2];

    always begin
        rFile[0] <= 0; // 0 address is hardwired to 0
        @(posedge clk) if (regWrite && writeAddr != 0) rFile[writeAddr] <= writeData;
    end


endmodule

`endif // REGFILE
