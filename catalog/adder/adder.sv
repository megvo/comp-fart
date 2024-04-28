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

`ifndef CUSTOM_ADDER
`define CUSTOM_ADDER

module custom_adder #(
    parameter SIZE = 32 
)(
    input [SIZE-1:0] A,
    input [SIZE-1:0] B,
    input Cin,
    output [SIZE-1:0] Result,
    output Cout
);

  
    wire [SIZE-1:0] carry;

   
    full_adder_custom fa0 (
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),
        .Sum(Result[0]),
        .Cout(carry[0])
    );

    genvar idx;
    generate
        for (idx = 1; idx < SIZE; idx = idx + 1) begin : full_adder_loop
            full_adder_custom fa (
                .A(A[idx]),
                .B(B[idx]),
                .Cin(carry[idx-1]),
                .Sum(Result[idx]),
                .Cout(carry[idx])
            );
        end
    endgenerate

    assign Cout = carry[SIZE-1];

endmodule

`endif

module full_adder_custom(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (A & Cin) | (B & Cin);
endmodule
