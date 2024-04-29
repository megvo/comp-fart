//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: adder                                                       //
//     Description: 32 bit adder                                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module adder #(
    parameter WIDTH = 32  // Parameter for the width of the adder
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    output [WIDTH-1:0] Y
);


    // LSB Adder
    full_adder fa0 (
        .A(A[0]),
        .B(B[0]),
        .Y(Y[0])
    );


    genvar i;
    generate
        for (i = 1; i < WIDTH; i = i + 1) begin : full_adder_loop
            full_adder fa (
                .A(A[i]),
                .B(B[i]),
                .Y(Y[i])
            );
        end
    endgenerate


endmodule

`endif // ADDER

// One-bit full adder logic
module full_adder(
    input A,
    input B,
    output Y
);
    assign Y = A ^ B;
endmodule
