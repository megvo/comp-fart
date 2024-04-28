//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2023-05-06                                                  //
//     Module Name: adder                                                       //
//     Description: Test bench for 32 bit adder.                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_adder;

    parameter WIDTH = 32;  // Parameter for the width of the adder
    reg [WIDTH-1:0] A, B;  // Inputs are reg for the testbench
    reg Cin;               // Carry-in for the testbench
    wire [WIDTH-1:0] Sum;  // Output Sum is wire for the testbench
    wire Cout;             // Carry-out for the testbench

    // UUT
    adder #(.WIDTH(WIDTH)) uut(
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .Sum(Sum), 
        .Cout(Cout)
    );

    // Initialize testbench
    initial begin
        $dumpfile("tb_adder.vcd"); 
        $dumpvars(0, uut);         
        
        // Apply random inputs
        A = $random; B = $random; Cin = 0; #10;
        A = $random; B = $random; Cin = 1; #10;
        A = $random; B = $random; Cin = 0; #10;
        A = $random; B = $random; Cin = 1; #10;

        
        $finish;
    end

    // Monitoring
    initial begin
        $monitor("Time = %0t: A = %b, B = %b, Cin = %b -> Sum = %b, Cout = %b",
                  $time, A, B, Cin, Sum, Cout);
    end

endmodule
