//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_alu                                                      //
//     Description: Testbench for 32-bit ALU                                    //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module alu_tb();
    logic [15:0] a, b;
    logic [2:0] ctrl;
    logic [15:0] result;
    logic zero;

    reg clk, reset;

    // Define test vectors directly within the testbench
    logic [55:0] testvectors[0:32];
    logic [15:0] vectornum, errors;
    logic [15:0] expectedResult;
    logic expectedZero;

    alu uut (
        .a(a),
        .b(b),
        .ctrl(ctrl),
        .result(result),
        .zero(zero)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_alu.vcd");
        $dumpvars(0, uut);
        
        testvectors[0]  = {3'b010, 16'h0000, 16'h0000, 16'h0000, 1'b1};
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; // Load test vector
        {ctrl, a, b, expectedResult, expectedZero} = testvectors[vectornum];
    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({result, zero} !== {expectedResult, expectedZero}) begin
                $display("Error:\tinputs: ctrl = %h, a = %h, b = %h", ctrl, a , b);
                $display("\tresult = %h, zero = %b\n\texpectedResult = %h, expectedZero = %h", result, zero, expectedResult, expectedZero);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 56'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end
endmodule
