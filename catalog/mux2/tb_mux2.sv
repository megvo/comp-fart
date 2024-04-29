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
`include "../mux2/mux2.sv"
`include "../clock/clock.sv"

module tb_mux4;
    parameter n = 32; // #bits for an operand
    logic [1:0] s;
    logic [(n-1):0] d0, d1, d2, d3;
    logic [(n-1):0] y;
    wire clk;
    logic enable;


   initial begin
        $dumpfile("mux2.vcd");
        $dumpvars(0, uut0, uut1);
        // $monitor("s = %0b d0 = (0x%0h)(%0d) d1 = (0x%0h)(%0d) y = (0x%0h)(%0d)", s, d0, d0, d1, d1, y, y);
        $monitor("time=%0t \t enable=%h s=%h y=%h d0=%h d1=%h d2=%h d3=%h",$realtime, enable, s, y, d0, d1, d2, d3);
    end

    initial begin
        d0 <= #n'h00000001;
        d1 <= #n'h00000002;
        d2 <= #n'h00000003;
        d3 <= #n'h00000005;
        enable <= 0;
        #10 enable <= 1;
        #10 s = 2'b11;
        #100 enable <= 0;
        $finish;
    end

    mux4 uut0(
        .S(s), .D0(d0), .D1(d1), .D2(d2), .D3(d3), .Y(y)
    );
    clock uut1(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule
`endif // TB_MUX2
