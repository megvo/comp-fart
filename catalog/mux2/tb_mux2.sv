//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: tb_mux2
//     Description: Test bench for 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MUX2
`define TB_MUX2

`timescale 1ns/100ps
`include "./mux2.sv"

module tb_mux2();
    parameter n = 16;
    logic s;
    logic [(n-1):0] a, b;
    logic [(n-1):0] result;

    reg clk;

    logic reset;
    logic [51:0] testvectors[0:1000];
    logic [15:0] vectornum, errors;
    logic [15:0] expectedResult;

    mux2 uut (
                .a(a),
                .b(b),
                .s(s),
                .result(result)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_mux2.vcd");
        $dumpvars(0, uut);
        testvectors[0] = {4'b0000, 16'hFFFF, 1'b0, 16'h0000};

        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; 
        {a, b, s, expectedResult} = testvectors[vectornum];
    end

    always @(posedge clk) begin
        if (~reset) begin
            if ({result} !== {expectedResult}) begin
                $display("Error\tinputs: a = %h, b = %h, s = %h", a, b, s);
                $display("\tresult = %h, expectedResult = %h", result, expectedResult);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 52'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end
endmodule
`endif //MUX2_TB
