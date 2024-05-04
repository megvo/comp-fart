//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2023-02-07
//     Module Name: sl2
//     Description: shift left by 2 (multiply by 4)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef SL1
`define SL1
`timescale 1ns/100ps

module sl1 (
    input logic [15:0] in,
    output logic [15:0] out
    );

    always @* begin
        out <= in << 1;
    end

endmodule

`endif // SL1
