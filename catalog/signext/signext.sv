//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: signext
//     Description: 16 to 32 bit sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef SIGNEXT
`define SIGNEXT

`timescale 1ns/100ps

module signext
    #(parameter n = 32, i = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [(i-1):0] A,
    output logic [(n-1):0] Y
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign Y = { {n{A[(i-1)]}}, A}; // sign extend (i-1)th bit i bits to the left.
endmodule

`endif // SIGNEXT
