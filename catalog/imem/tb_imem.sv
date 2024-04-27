//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-04-27
//     Module Name: tb_imem
//     Description: Test bench for instruction memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_IMEM
`define TB_IMEM

`timescale 1ns/100ps
`include "imem.sv"

module tb_imem;
    parameter n = 32; // this is the bit length of registers
    parameter r = 6; // r = 6
    logic [(n-1):0] read_dat;
    logic [(r-1):0] imem_addr;

   initial begin
        $dumpfile("imem.vcd");
        $dumpvars(0, uut);
        //$monitor("enable = %b clk = %b", enable, clk);
        $monitor("time=%0t \t imem_addr=%b read_dat=%h",$realtime, imem_addr, read_dat);
    end

    initial begin
        #10 imem_addr <= #(r)'b000000;
        #10 imem_addr <= #(r)'b000001;
        #10 imem_addr <= #(r)'b000010;
        $finish;
    end

   imem uut(
        .addr(imem_addr),
        .read_dat(read_dat)
    );
endmodule

`endif // TB_IMEM
