//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Lamiah Khan and Megan Vo
// 
//     Create Date: 2023-02-07
//     Module Name: tb_maindec
//     Description: Test bench for simple behavorial main decoder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MAINDEC
`define TB_MAINDEC

`timescale 1ns/100ps
`include "maindec.sv"

module tb_maindec;
      // Test input signals
    reg [5:0] op;
    reg [5:0] funct;

    // Test output signals
    wire [1:0] memtoreg;
    wire memwrite;
    wire branch, alusrc;
    wire [1:0] regdst;
    wire regwrite;
    wire [1:0] jump;
    wire [1:0] aluop;
  // Instantiate the maindec module
    maindec #(32) dut (
        .op(op),
        .funct(funct),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .branch(branch),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .aluop(aluop)
    );

    // Initialize signals
    initial begin
        $monitor("op=%b funct=%b memtoreg=%b memwrite=%b branch=%b alusrc=%b regdst=%b regwrite=%b jump=%b aluop=%b",
                 op, funct, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop);

        // Test case 1: R-type instruction (op = 000000, funct = 000111)
        #10;
        op = 6'b000000;
        funct = 6'b000111;
         // Test case 2: LW instruction (op = 000001)
        #10;
        op = 6'b000001;
        funct = 6'bxxxxxx;

        // Test case 3: SW instruction (op = 000010)
        #10;
        op = 6'b000010;
        funct = 6'bxxxxxx;

        // Test case 4: ADDI instruction (op = 000011)
        #10;
        op = 6'b000011;
        funct = 6'bxxxxxx;

        // Test case 5: SUBI instruction (op = 000100)
        #10;
        op = 6'b000100;
        funct = 6'bxxxxxx;

        // Test case 6: BEQ instruction (op = 000101)
        #10;
        op = 6'b000101;
        funct = 6'bxxxxxx;
            // Test case 7: J instruction (op = 000111)
        #10;
        op = 6'b000111;
        funct = 6'bxxxxxx;

        // Test case 8: Jal instruction (op = 001000)
        #10;
        op = 6'b001000;
        funct = 6'bxxxxxx;

        // Test case 9: Illegal operation
        #10;
        op = 6'b101010;
        funct = 6'bxxxxxx;

        // Test case 10: Jr instruction (funct = 001000)
        #10;
        op = 6'b000000;
        funct = 6'b000111;

        // Finish simulation
        #10;
        $finish;
    end

endmodule
`endif // TB_MAINDEC
