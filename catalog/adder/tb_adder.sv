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

`include "./adder.sv"

module adder_tb();
    logic [15:0] a;
    logic [15:0] b;
    logic [15:0] result;

    reg clk, reset; //reset for initializing testvectors

    logic [47:0] testvectors[0:1000];
    integer vectornum, errors;
    logic [15:0] expectedResult;


    adder uut (
             .a(a),
             .b(b),
             .result(result)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_adder.vcd");
        $dumpvars(0, uut);
        
        testvectors[0] = {16'hFFFF, 16'h0000, 16'hFFFF};
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; 
        {a, b, expectedResult} = testvectors[vectornum];
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (result !== expectedResult) begin
                $display("Error:\tinputs: a = %h, b=%h", a, b);
                $display("\tresult = %h, expectedResult = %h", result, expectedResult);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 48'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
