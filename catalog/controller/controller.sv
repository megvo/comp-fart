//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             // 
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: controller                                                  //
//     Description: 32-bit RISC-based CPU controller                            //
//                                                                              //    
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER
`timescale 1ns/100ps

`include "../maindec/maindec.sv"

module controller (
    input logic [3:0] op,
    input logic zero,
    output logic regWrite, memWrite, pcSrc,
    output logic [1:0] regDst, memToReg, jump, aluSrc,
    output logic [2:0] aluCtrl
    );


    logic branch;
    maindec mainDecoder(
        op,
        regWrite,
        branch,
        memWrite,
        regDst,
        memToReg,
        jump,
        aluSrc,
        aluCtrl
        );
    assign pcSrc = branch & zero;
endmodule

`endif // CONTROLLER
