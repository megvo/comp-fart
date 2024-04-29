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
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps

module tb_adder;

    parameter WIDTH = 32;  // Parameter for the width of the adder
    reg [WIDTH-1:0] A, B;  // Inputs are reg for the testbench
    wire [WIDTH-1:0] Y;  // Output Y is wire for the testbench
    

    // UUT
    adder #(.WIDTH(WIDTH)) uut(
        .A(A), 
        .B(B),  
        .Y(Y)
    );

    // Initialize testbench
    initial begin
        $dumpfile("tb_adder.vcd"); 
        $dumpvars(0, uut);         
        
        // Apply random inputs
        A = $random; B = $random; #10;
        A = $random; B = $random; #10;
        A = $random; B = $random; #10;
        A = $random; B = $random; #10;

        
        $finish;
    end

    // Monitoring
    initial begin
        $monitor("Time = %0t: A = %b, B = %b, Y = %b ",
                  $time, A, B, Y);
    end

endmodule
`endif 
