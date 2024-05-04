//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //  
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_cpu                                                       //
//     Description: Testbench for a 32-bit RISC-based CPU (MIPS)                //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./cpu.sv"

module tb_cpu();
    logic rst;
    logic [15:0] instruction, readData;

    logic memWrite;
    logic [15:0] aluResult, memWriteData, pc;

    reg clk, reset; //reset for initializing testvectors

    logic [87:0] testvectors[0:1000];
    integer vectornum, errors;

    //expected
    logic expectedMemWrite;
    logic [15:0] expectedAluResult, expectedMemWriteData, expectedPc;

    cpu uut (
             .clk(clk),
             .rst(rst),
             .instruction(instruction),
             .readData(readData),
             .memWrite(memWrite),
             .aluResult(aluResult),
             .memWriteData(memWriteData),
             .pc(pc)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_cpu.vcd");
        $dumpvars(0, uut);
        testvectors[0] = {1'b0, 16'ha443, 16'h0000, 1'b0, 16'h000a, 16'h0007, 16'h0004};
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        {rst, instruction, readData, expectedMemWrite, expectedAluResult, expectedMemWriteData, expectedPc} = testvectors[vectornum];
    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({memWrite, aluResult, memWriteData, pc} !== {expectedMemWrite, expectedAluResult, expectedMemWriteData, expectedPc}) begin
                $display("Error:\tinputs: {rst, instruction, readData} = %b %b %b", rst, instruction, readData);
                $display("\tmemWrite= %h, expectedMemWrite = %h", memWrite, expectedMemWrite);
                $display("\taluResult = %h, expectedAluResult = %h", aluResult, expectedAluResult);
                $display("\tmemWriteData = %h, expectedMemWriteData = %h", memWriteData, expectedMemWriteData);
                $display("\tpc = %h, expectedPc = %h", pc, expectedPc);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 88'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
