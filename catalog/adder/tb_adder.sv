//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-28                                                  //
//     Module Name: tb_adder                                                    //
//     Description: Test bench for 32 bit adder.                                //
//                                                                              //
// Revision: 1.0                                                                //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_adder;

    parameter SIZE = 32;  
    reg [SIZE-1:0] A, B;  
    reg Cin;              
    wire [SIZE-1:0] Result; 
    wire Cout;            

    custom_adder #(.SIZE(SIZE)) uut(
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .Result(Result), 
        .Cout(Cout)
    );

    // Initialize testbench
    initial begin
        $dumpfile("tb_custom_adder.vcd"); 
        $dumpvars(0, uut);         
        
        
        A = $random; B = $random; Cin = 0; #10;
        A = $random; B = $random; Cin = 1; #10;
        A = $random; B = $random; Cin = 0; #10;
        A = $random; B = $random; Cin = 1; #10;

        
        $finish;
    end

    
    initial begin
        $monitor("Time = %0t: A = %b, B = %b, Cin = %b -> Result = %b, Cout = %b",
                  $time, A, B, Cin, Result, Cout);
    end

endmodule
