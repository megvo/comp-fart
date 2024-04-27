//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////

`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "regfile.sv"
`include "alu.sv"
`include "dff.sv"
`include "adder.sv"
`include "sl2.sv"
`include "mux2.sv"
`include "signext.sv"

module datapath
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic clk, reset,
    input  logic [1:0]  memoryReg, 
    input  logic pc_data,
    input  logic alu_data, 
    input  logic [1:0] regsDestina, 
    input  logic regs_write,
    input  logic [1:0] jump,
    input  logic [2:0] testAlu,
    output logic zero,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instruction,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [4:0]  writereg;
    logic [(n-1):0] pcnext, pcnextbr, pcplus4, pcbranch;
    logic [(n-1):0] signimm, signimmsh;
    logic [(n-1):0] srca, srcb;
    logic [(n-1):0] result;
    reg Cout1, Cout2;   

    // "next PC" logic
    dff #(n)  pcreg(clk, reset, pcnext, pc);
  adder       pcadd1(.A(pc), .B(4), .Cin(1'b0), .Cout(Cout1), .Sum(pcplus4));
    sl2         immsh(signimm, signimmsh);
  adder       pcadd2(.A(pcplus4), .B(signimmsh), .Cin(1'b0), .Cout(Cout2), .Sum(pcbranch));
    mux2 #(n)   pcbrmux(pcplus4, pcbranch, pc_data, pcnextbr);
    mux4 #(n)   pcmux(pcnextbr, {pcplus4[31:28], instruction[25:0], 2'b00}, readdata, 32'hxxxxxxxx, jump, pcnext);

    // register file logic
    regfile     rf(clk, regs_write, instruction[25:21], instruction[20:16], writereg, result, srca, writedata);
    mux4 #(5)   wrmux(instruction[20:16], instruction[15:11], 5'b01111, 5'bxxxxx, regsDestina, writereg);
    mux4 #(n)   resmux(aluout, readdata, pcplus4, 32'hxxxxxxxx, memoryReg, result);
    signext     se(instruction[15:0], signimm);

    // ALU logic
    mux2 #(n)   srcbmux(writedata, signimm, alu_data, srcb);
    alu         alu(clk, srca, srcb, testAlu, aluout, zero);

endmodule

`endif // DATAPATH
