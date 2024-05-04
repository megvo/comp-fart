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

`timescale 1ns/100ps

`include "./imem.sv"

module imem_tb();
    logic [4:0] address;
    logic [15:0] instruction;

    reg clk, reset; //reset for initializing testvectors

    logic [23:0] testvectors[0:1000];
    integer vectornum, errors;
    logic [15:0] expectedInstruction;


    imem uut (
             .address(address),
             .instruction(instruction)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_imem.vcd");
        $dumpvars(0, uut);
    
        testvectors[0] = {8'h02, 16'h0002};
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(posedge clk) begin
        #1; 
        {address, expectedInstruction} = testvectors[vectornum];
        
    end

    always @(negedge clk) begin
        #1;
        if (~reset) begin
            if (instruction !== expectedInstruction) begin
                $display("Error:\tinputs: address = %h", address);
                $display("\tinstruction = %h, expectedInstruction = %h", instruction, expectedInstruction);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 24'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
