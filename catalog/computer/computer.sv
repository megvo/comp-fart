//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //                                                   
//     Module Name: computer                                                    // 
//     Description: 32-bit RISC                                                 //
//                                                                              //
//                                                                              //
//                                                                              // 
//////////////////////////////////////////////////////////////////////////////////
 `ifndef COMPUTER
`define COMPUTER
`timescale 1ns/100ps

`include "../cpu/cpu.sv"
`include "../imem/imem.sv"
`include "../dmem/dmem.sv"

module computer (
    input logic clk, rst,
    output logic [15:0] writeData, address,
    output logic memWrite
    );

    logic [15:0] instruction, readData, pc;

    cpu compfart(
        clk,
        rst,
        instruction,
        readData,
        memWrite,
        address,
        writeData,
        pc
    );


    imem imem(
        pc[5:1],
        instruction
    );

    dmem dmem(
        clk,
        memWrite,
        address,
        writeData,
        readData
    );

endmodule

`endif // COMPUTER
