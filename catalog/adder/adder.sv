//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: adder
//     Description: simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module adder
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [(n-1):0] A, B,
    output logic [(n-1):0] Y
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    assign Y = A + B;
endmodule

`endif // ADDER
