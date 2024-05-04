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
`timescale 1ns/100ps

`include "./datapath.sv"

module tb_datapath();
    logic rst, regWrite, pcSrc;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic [2:0] aluCtrl;
    logic [15:0] instruction, readData;

    logic[15:0] aluResult, memWriteData, pc;
    logic zero;

    reg clk, reset; //reset for initializing testvectors

    logic [139:0] testvectors[0:1000];
    integer vectornum, errors;
  

    logic [15:0] expectedAluResult, expectedMemWriteData, expectedPc;
    logic expectedZero;


    datapath uut (
             .clk(clk),
             .rst(rst),
             .regWrite(regWrite),
             .regDst(regDst),
             .memToReg(memToReg),
             .jump(jump),
             .aluSrc(aluSrc),
             .pcSrc(pcSrc),
             .aluCtrl(aluCtrl),
             .instruction(instruction),
             .readData(readData),
             .aluResult(aluResult),
             .memWriteData(memWriteData),
             .pc(pc),
             .zero(zero)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_datapath.vcd");
        $dumpvars(0, uut);
        // 0_1_00_00_00_01_0_010_a047_0000___0007_XXXX_0002_0
        
        testvectors[0] = {1'b0, 1'b0, 2'b00, 2'b00, 2'b00, 2'b01, 1'b0, 3'b000, 16'h0000, 16'h0000, 16'h0000, 16'h0000, 16'hXXXX, 1'b1};
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        {rst, regWrite, regDst, memToReg, jump, aluSrc, pcSrc, aluCtrl, instruction, readData, expectedAluResult, expectedMemWriteData, expectedPc, expectedZero} = testvectors[vectornum];



    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({aluResult, memWriteData, pc, zero} !== {expectedAluResult, expectedMemWriteData, expectedPc, expectedZero}) begin
                $display("Error:\tinputs: {rst,regWrite,regDst,memToReg,jump,aluSrc,pcSrc,aluCtrl} = %b %b %b %b %b %b %b %b", rst, regWrite, regDst, memToReg, jump, aluSrc, pcSrc, aluCtrl);
                $display("      \tinstruction = %h, readData = %h", instruction, readData);
                $display("\taluResult = %h, expectedAluResult = %h", aluResult, expectedAluResult);
                $display("\tmemWriteData = %h, expectedMemWriteData = %h", memWriteData, expectedMemWriteData);
                $display("\tpc = %h, expectedPc = %h", pc, expectedPc);
                $display("\tzero = %b, expectedZero = %h", zero, expectedZero);

                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 140'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
