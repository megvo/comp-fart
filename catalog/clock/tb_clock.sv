//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: tb_clock
//     Description: Test bench for clock generator
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_CLOCK
`define TB_CLOCK

`timescale 1ns/100ps
`include "clock.sv"

module tb_clock;
    wire clk;
    logic enable;

    initial begin
        $dumpfile("clock.vcd");
        $dumpvars(0, uut);
        //$monitor("enable = %b clk = %b", enable, clk);
        $monitor("time=%0t \t enable=%b clk=%b",$realtime, enable, clk);
    end

    initial begin
        enable = 0;
        #10 enable = 1;
        #100 enable = 0;
        $finish;
    end

    custom_clock uut(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule

`endif // TB_CLOCK

