//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_adder;

    parameter WIDTH = 32;  
    reg [WIDTH-1:0] A, B; 
    reg Cin;               
    wire [WIDTH-1:0] Sum;  
    wire Cout;             

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
