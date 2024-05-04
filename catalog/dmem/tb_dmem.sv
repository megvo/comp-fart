//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_dmem
//     Description: Test bench for data memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./dmem.sv"

module dmem_tb();
    logic memWrite;
    logic [15:0] address, writeData;

    logic [15:0] readData;

    reg clk, reset; //reset for initializing testvectors

    logic [51:0] testvectors[0:1000];
    integer vectornum, errors;
    logic [15:0] expectedReadData;


    dmem uut (
             .clk(clk),
             .memWrite(memWrite),
             .address(address),
             .writeData(writeData),
             .readData(readData)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_dmem.vcd");
        $dumpvars(0, uut);
    
        testvectors[0] = {1'b1, 16'h000E, 16'h000E, 16'h000E};
        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

    always @(negedge clk) begin
        #1; 
        {memWrite, address, writeData, expectedReadData} = testvectors[vectornum];

    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            if (readData !== expectedReadData) begin
                $display("Error:\tinputs: memWrite = %b, address = %h, writeData = %h", memWrite, address, writeData);
                $display("\treadData = %h, expectedReadData = %h", readData, expectedReadData);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 52'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
