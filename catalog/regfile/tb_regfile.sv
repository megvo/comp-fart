//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2024-27-04
//     Module Name: tb_regfile
//     Description: Test bench for simple behavorial register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_REGFILE
`define TB_REGFILE

`timescale 1ns/100ps
`include "../regfile/regfile.sv"

module tb_regfile;
    parameter n = 32;

endmodule
`endif // TB_REGFILE
