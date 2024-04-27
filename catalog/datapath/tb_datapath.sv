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
`include "datapath.sv"
`include "../clock/clock.sv"
`include "../controller/controller.sv"
`timescale 1ns/100ps

module datapath_tb;
    parameter n = 32;
    reg clk, reset; 
    reg alu_data, pc_data, regs_write;
  reg [1:0] memoryReg, regsDestina, jump;
  reg [(n-1):0] instruction, readdata;
  reg [2:0] testAlu;

  // Define output signals
    wire [31:0] pc, aluout, writedata;
    logic [5:0] opcode, functi;
    logic zero;
    
    // Testbench Outputs
    logic memwrite;
    
assign opcode = instruction[31:26];
assign functi = instruction[5:0];

    datapath dut1 (
    .clk(clk),
    .reset(reset),
    .memoryReg(memoryReg),
    .pc_data(pc_data),
    .alu_data(alu_data),
    .regsDestina(regsDestina),
    .regs_write(regs_write),
    .jump(jump),
    .testAlu(testAlu),
    .zero(zero),
    .pc(pc),
    .instruction(instruction),
    .aluout(aluout),
    .writedata(writedata),
    .readdata(readdata)
  );

    controller dut2 (
        .opcode(opcode),
        .functi(functi),
        .zero(zero1),
        .memoryReg(memoryReg),
        .memwrite(memwrite),
        .pc_data(pc_data),
        .alu_data(alu_data),
        .regsDestina(regsDestina),
        .regs_write(regs_write),
        .jump(jump),
        .testAlu(testAlu)
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
//test for if zero = 0;
instruction = 32'h0C0D000F;  
#10;
$display("instruction =%h zero =%h pc =%h testAlu =%h aluout =%h writedata=%h", instruction, zero, pc, testAlu, aluout, writedata);
instruction=  32'h0C0D000A;  
#10;
$display("instruction =%h zero =%h pc =%h testAlu =%h aluout =%h writedata=%h ", instruction, zero, pc, testAlu, aluout, writedata);
instruction = 32'b00001001100000100000000000000100;  //stores word  
#10
 $display("instruction =%h zero =%h pc =%h testAlu =%h aluout =%h writedata=%h memwrite=%h", instruction, zero, pc, testAlu, aluout, writedata, memwrite);
 instruction= 32'b00000101100000110000000000000100;
 //instr= 32'b00001000010011000000000000000100;  //loads word
 #10;
 $display("instruction =%h zero =%h pc =%h testAlu =%h aluout =%h writedata=%h memoryReg=%h", instruction, zero, pc, testAlu, aluout, writedata, memoryReg);
$finish;
end
endmodule
`endif // TB_DATAPATH
