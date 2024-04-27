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

module adder #(
    parameter WIDTH = 8  // Parameter for the width of the adder
)(
    input [WIDTH-1:0] A,
    input [WIDTH-1:0] B,
    input Cin,
    output [WIDTH-1:0] Sum,
    output Cout
);

    // Carry wire
    wire [WIDTH-1:0] carry;

    // LSB Adder
    full_adder fa0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Sum[0]),
        .Cout(carry[0])
    );

    // Need more adders for the rest of bits required (7)
    genvar i;
    generate
        for (i = 1; i < WIDTH; i = i + 1) begin : full_adder_loop
            full_adder fa (
                .A(A[i]),
                .B(B[i]),
                .Cin(carry[i-1]),
                .Sum(Sum[i]),
                .Cout(carry[i])
            );
        end
    endgenerate

    // Carry out is from MSB
    assign Cout = carry[WIDTH-1];

endmodule

`endif // ADDER

// One-bit full adder logic
module full_adder(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule
