//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //   
//     Module Name: tb_computer                                                 //
//     Description: Test bench for a single-cycle MIPS computer                 // 
//                                                                              //
//                                                                              //  
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/100ps

`include "./computer.sv"
`include "../clock/clock.sv"

module tb_computer();

    logic clk;
    logic clk_enable;
    logic rst;
    logic [15:0] writeData, address;
    logic memWrite;

   
    clock dut_clock(.ENABLE(clk_enable), .CLOCK(clk));

    
    computer dut(.clk(clk), .rst(rst), .writeData(writeData), .address(address), .memWrite(memWrite));

    
    initial begin
        $dumpfile("tb_computer.vcd");
        $dumpvars(0, dut, dut_clock); // Include clock module in VCD dump
    end

    always #5 clk_enable = ~clk_enable; 

   
    initial begin
        rst = 1; 
        #50; 
        rst = 0; 
    end

    always @(negedge clk) begin
        if (memWrite && address === 0) begin
            $display("Address: %h", address);
            $display("Output (hex): %h", writeData);
            $display("Output (dec): %d", writeData);
            $finish();
        end
    end
    
endmodule
