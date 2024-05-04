//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //  
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: cpu                                                         //
//     Description: 32-bit RISC-based CPU (MIPS)                                //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU
`timescale 1ns/100ps

`include "../datapath/datapath.sv"
`include "../controller/controller.sv"

module cpu (
    input logic clk, rst,
    input logic [15:0] instruction, readData,
    output logic memWrite,
    output logic [15:0] aluResult, memWriteData, pc
    );
    logic zero, regWrite, pcSrc;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic [2:0] aluCtrl;

    controller cf_controller(
        instruction[15:12],
        zero,
        regWrite,
        memWrite,
        pcSrc,
        regDst,
        memToReg,
        jump,
        aluSrc,
        aluCtrl
        );
    datapath cf_datapath(
        clk,
        rst,
        regWrite,
        pcSrc,
        regDst,
        memToReg,
        jump,
        aluSrc,
        aluCtrl,
        instruction,
        readData,
        aluResult,
        memWriteData,
        pc,
        zero
        );
endmodule

`endif // CPU
