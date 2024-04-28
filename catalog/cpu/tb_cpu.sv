//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //  
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_cpu                                                         //
//     Description: Testbench for a 32-bit RISC-based CPU (MIPS)                //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module tb_cpu;

    // Parameters
    parameter n = 32;

    logic clk = 0;
    logic reset = 0;
    logic [(n-1):0] instr = 0;
    logic [(n-1):0] readdata = 0;

    logic [(n-1):0] pc;
    logic memwrite;
    logic [(n-1):0] aluout, writedata;


    cpu dut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instr(instr),
        .memwrite(memwrite),
        .aluout(aluout),
        .writedata(writedata),
        .readdata(readdata)
    );

    always #5 clk = ~clk;

initial begin 
clk=0;
reset=1;
#10;
reset=0;
//zero=0;
readdata = 32'hdeadbeef;
instr = 32'h050C0004; 
#10;
$display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
instr =  32'h0C0D000F;  
#10;
$display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
instr = 32'b00001001100000100000000000000100;  
#10
 $display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
 instr= 32'b00000101100000110000000000000100;
 #10;
 $display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
$finish;
end

endmodule
