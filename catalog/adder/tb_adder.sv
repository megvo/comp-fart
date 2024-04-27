//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2023-04-27
//     Module Name: tb_adder
//     Description: Test bench for simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ADDER
`define TB_ADDER

`timescale 1ns/100ps
`include "adder.sv"

module tb_adder;
    parameter n = 32;
    logic [(n-1):0] a, b, y;

   initial begin
        $dumpfile("adder.vcd");
        $dumpvars(0, uut);
        $monitor("a = 0x%0h b = 0x%0h y = 0x%0h", a, b, y);
    end

    initial begin
        a <= #n'hFFFFFFFF;
        b <= #n'hFFFFFFFF;
    end

    adder uut(
        .A(a), .B(b), .Y(y)
    );
endmodule
`endif // TB_ADDER
