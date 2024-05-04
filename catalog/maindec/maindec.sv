////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineers: Lamiah Khan and Megan Vo
// 
// Create Date: 2024-07-27
// Module Name: maindec
// Description: 32-bit RISC-based CPU main decoder (MIPS)
//
////////////////////////////////////////////////////////////////////////////////

`ifndef MAINDEC
`define MAINDEC
`timescale 1ns/100ps
`include "../alu/alu.sv"

module maindec (
    input logic [3:0] op,
    output logic regWrite, branch, memWrite,
    output logic [1:0] regDst, memToReg, jump, aluSrc,
    output logic [2:0] aluCtrl
    );

      `define MAINDEC_CTRL_ADD    4'b0000
      `define MAINDEC_CTRL_SUB    4'b0001
      `define MAINDEC_CTRL_MOVE   4'b0010
      `define MAINDEC_CTRL_JR     4'b0011
      `define MAINDEC_CTRL_AND    4'b0100
      `define MAINDEC_CTRL_OR     4'b0101
      `define MAINDEC_CTRL_SLL    4'b0110
      `define MAINDEC_CTRL_SRL    4'b0111
      `define MAINDEC_CTRL_SLT    4'b1000
      `define MAINDEC_CTRL_BEQ    4'b1001
      `define MAINDEC_CTRL_ADDI   4'b1010
      `define MAINDEC_CTRL_SUBI   4'b1011
      `define MAINDEC_CTRL_LW     4'b1100
      `define MAINDEC_CTRL_SW     4'b1101
      `define MAINDEC_CTRL_J      4'b1110
      `define MAINDEC_CTRL_JAL    4'b1111

    logic [13:0] ctrl;
    assign {regWrite, regDst, branch, memWrite, memToReg, jump, aluSrc, aluCtrl} = ctrl;

    always @*
        case(op)
            `MAINDEC_CTRL_ADD:  ctrl <= {11'b10100000000, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_SUB:  ctrl <= {11'b10100000000, `ALU_CTRL_SUB};
            `MAINDEC_CTRL_MOVE: ctrl <= {11'b10100000000, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_JR:   ctrl <= {11'b00000001000, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_AND:  ctrl <= {11'b10100000000, `ALU_CTRL_AND};
            `MAINDEC_CTRL_OR:   ctrl <= {11'b10100000000, `ALU_CTRL_OR};
            `MAINDEC_CTRL_SLL:  ctrl <= {11'b10100000010, `ALU_CTRL_SLL};
            `MAINDEC_CTRL_SRL:  ctrl <= {11'b10100000010, `ALU_CTRL_SRL};
            `MAINDEC_CTRL_SLT:  ctrl <= {11'b10100000000, `ALU_CTRL_SLT};

            `MAINDEC_CTRL_BEQ:  ctrl <= {11'b00010000000, `ALU_CTRL_SUB};
            `MAINDEC_CTRL_ADDI: ctrl <= {11'b10000000001, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_SUBI: ctrl <= {11'b10000000001, `ALU_CTRL_SUB};
            `MAINDEC_CTRL_LW:   ctrl <= {11'b10000010001, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_SW:   ctrl <= {11'b00001000001, `ALU_CTRL_ADD};

            `MAINDEC_CTRL_J:    ctrl <= {11'b00000000100, `ALU_CTRL_ADD};
            `MAINDEC_CTRL_JAL:  ctrl <= {11'b11000100100, `ALU_CTRL_ADD};
            default: ctrl <= 14'bx; // illegal
        endcase
endmodule

`endif // MAINDEC
