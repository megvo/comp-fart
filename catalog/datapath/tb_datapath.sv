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
`ifndef TB_DATAPATH
`define TB_DATAPATH
`include "../datapath/datapath.sv"
`include "../clock/clock.sv"
`include "../controller/controller.sv"
`timescale 1ns/100ps

module datapath_tb;
    parameter n = 32;
    reg clk, reset, alusrc, pcsrc, regwrite;
    reg [1:0] memtoreg, regdst, jump;
    reg [2:0] alucontrol;
    reg [(n-1):0] instr, readdata;

  // Define output signals
    wire [31:0] pc, aluout, writedata;
    

    logic [5:0] op, funct;
    logic zero;

    // Testbench Outputs
    logic memwrite;
    //logic alusrc;
    //logic regwrite;
   // logic jump;
   //logic [2:0] alucontrol;

assign op=instr[31:26];
assign funct=instr[5:0];

    datapath dut1 (
    .clk(clk),
    .reset(reset),
    .memtoreg(memtoreg),
    .pcsrc(pcsrc),
    .alusrc(alusrc),
    .regdst(regdst),
    .regwrite(regwrite),
    .jump(jump),
    .alucontrol(alucontrol),
    .zero(zero),
    .pc(pc),
    .instr(instr),
    .aluout(aluout),
    .writedata(writedata),
    .readdata(readdata)
  );

    controller dut2 (
        .op(op),
        .funct(funct),
        .zero(zero1),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol)
    );
//   initial begin 
//     $display("instr =%h zero =%h pc =%h alucontrol =%h aluout =%h writedata=%h", instr, zero, pc, alucontrol, aluout, writedata);
//   end


always #5 clk = ~clk;

initial begin 
clk=0;
reset=1;
#10;
reset=0;
//zero=0;
instr = 32'h0C0D000F;  //addi $v1, $zero, 15
#10;
$display("instr =%h zero =%h pc =%h alucontrol =%h aluout =%h writedata=%h", instr, zero, pc, alucontrol, aluout, writedata);
instr=  32'h0C0D000A;  //addi $v0, $zero, 10
#10;
$display("instr =%h zero =%h pc =%h alucontrol =%h aluout =%h writedata=%h ", instr, zero, pc, alucontrol, aluout, writedata);
instr = 32'b00001001100000100000000000000100;  //store word  
#10
 $display("instr =%h zero =%h pc =%h alucontrol =%h aluout =%h writedata=%h memwrite=%h", instr, zero, pc, alucontrol, aluout, writedata, memwrite);
 instr= 32'b00000101100000110000000000000100;
 //instr= 32'b00001000010011000000000000000100;  //load word
 #10;
 $display("instr =%h zero =%h pc =%h alucontrol =%h aluout =%h writedata=%h memtoreg=%h", instr, zero, pc, alucontrol, aluout, writedata, memtoreg);
$finish;
end




endmodule
