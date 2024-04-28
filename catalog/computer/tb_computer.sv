//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: tb_computer
//     Description: Test bench for a single-cycle MIPS computer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_COMPUTER
`define TB_COMPUTER

`timescale 1ns/100ps

`include "computer.sv"
`include "../clock/clock.sv"

module tb_computer;
  parameter n = 32; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
  parameter m = 5;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
  logic clk;
  logic clk_enable;
  logic reset;
  logic memwrite;
  logic [31:0] writedata;
  logic [31:0] dataadr;

  logic firstTest, secondTest;

  computer dut(clk, reset, writedata, dataadr, memwrite);

  clock dut1(.ENABLE(clk_enable), .CLOCK(clk));


  initial begin
    firstTest = 1'b0;
    secondTest = 1'b0;
    $dumpfile("computer.vcd");
    $dumpvars(0,dut,clk,reset,writedata,dataadr,memwrite);
  end

  initial begin
    #0 clk_enable <= 0; #50 reset <= 1; # 50; reset <= 0; #50 clk_enable <= 1;
  end

  
  always @(posedge clk)
  begin
      $display("+");
      $display("\t+instr = 0x%h",dut.instr);
      $display("\t+op = 0b%6b",dut.compfart.c.op);
      $display("\t+controls = 0b%9b",dut.compfart.c.md.controls);
      $display("\t+funct = 0b%6b",dut.compfart.c.ad.funct);
      $display("\t+aluop = 0b%2b",dut.compfart.c.ad.aluop);
      $display("\t+alucontrol = 0b%3b",dut.compfart.c.ad.alucontrol);
      $display("\t+alu result = 0x%8h",dut.compfart.dp.alu.result);
      $display("\t+HiLo = 0x%8h",dut.compfart.dp.alu.HiLo);
      $display("\t+$gpr1 = 0x%4h",dut.compfart.dp.rf.rf[1]);
      $display("\t+$gpr2 = 0x%4h",dut.compfart.dp.rf.rf[2]);
      $display("\t+$gpr3 = 0x%4h",dut.compfart.dp.rf.rf[3]);
      $display("\t+$gpr4 = 0x%4h",dut.compfart.dp.rf.rf[4]);
      $display("\t+$a0 = 0x%4h",dut.compfart.dp.rf.rf[5]);
      $display("\t+$a1 = 0x%4h",dut.compfart.dp.rf.rf[6]);
      $display("\t+$a2 = 0x%4h",dut.compfart.dp.rf.rf[7]);
      $display("\t+$t0 = 0x%4h",dut.compfart.dp.rf.rf[8]);
      $display("\t+$t1 = 0x%4h",dut.compfart.dp.rf.rf[9]);
      $display("\t+$t2 = 0x%4h",dut.compfart.dp.rf.rf[10]);
      $display("\t+$t3 = 0x%4h",dut.compfart.dp.rf.rf[11]);
      $display("\t+$v0 = 0x%4h",dut.compfart.dp.rf.rf[12]);
      $display("\t+$v1 = 0x%4h",dut.compfart.dp.rf.rf[13]);
      $display("\t+$sp = 0x%4h",dut.compfart.dp.rf.rf[14]);
      $display("\t+$ra = 0x%4h",dut.compfart.dp.rf.rf[15]);

      $display("\t+regfile -- ra1 = %d",dut.compfart.dp.rf.ra1);
      $display("\t+regfile -- ra2 = %d",dut.compfart.dp.rf.ra2);
      $display("\t+regfile -- we3 = %d",dut.compfart.dp.rf.we3);
      $display("\t+regfile -- wa3 = %d",dut.compfart.dp.rf.wa3);
      $display("\t+regfile -- wd3 = %d",dut.compfart.dp.rf.wd3);
      $display("\t+regfile -- rd1 = %d",dut.compfart.dp.rf.rd1);
      $display("\t+regfile -- rd2 = %d",dut.compfart.dp.rf.rd2);
      $display("\t+RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
      $display("\t+PC = %d", dut.compfart.dp.pc);
      $display("\t+memtoreg %h memwrite %h branch %h alusrc %h regdst %h regwrite %h jump %h" , 
      dut.compfart.c.md.memtoreg, dut.compfart.c.md.memwrite, dut.compfart.c.md.branch, dut.compfart.c.md.alusrc
      , dut.compfart.c.md.regdst, dut.compfart.c.md.regwrite, dut.compfart.c.md.jump );
      $display("\t+rewritedata %h dataadr %h memwrite %h", writedata, dataadr, memwrite);
  end

  
  always @(negedge clk) begin
    $display("-");
    $display("\t-instr = 0x%h",dut.instr);
    $display("\t-op = 0b%6b",dut.compfart.c.op);
    $display("\t-controls = 0b%9b",dut.compfart.c.md.controls);
    $display("\t-funct = 0b%6b",dut.compfart.c.ad.funct);
    $display("\t-aluop = 0b%2b",dut.compfart.c.ad.aluop);
    $display("\t-alucontrol = 0b%3b",dut.compfart.c.ad.alucontrol);
    $display("\t-alu result = 0x%8h",dut.compfart.dp.alu.result);
    $display("\t-HiLo = 0x%8h",dut.compfart.dp.alu.HiLo);
      $display("\t+$gpr1 = 0x%4h",dut.compfart.dp.rf.rf[1]);
      $display("\t+$gpr2 = 0x%4h",dut.compfart.dp.rf.rf[2]);
      $display("\t+$gpr3 = 0x%4h",dut.compfart.dp.rf.rf[3]);
      $display("\t+$gpr4 = 0x%4h",dut.compfart.dp.rf.rf[4]);
      $display("\t+$a0 = 0x%4h",dut.compfart.dp.rf.rf[5]);
      $display("\t+$a1 = 0x%4h",dut.compfart.dp.rf.rf[6]);
      $display("\t+$a2 = 0x%4h",dut.compfart.dp.rf.rf[7]);
      $display("\t+$t0 = 0x%4h",dut.compfart.dp.rf.rf[8]);
      $display("\t+$t1 = 0x%4h",dut.compfart.dp.rf.rf[9]);
      $display("\t+$t2 = 0x%4h",dut.compfart.dp.rf.rf[10]);
      $display("\t+$t3 = 0x%4h",dut.compfart.dp.rf.rf[11]);
      $display("\t+$v0 = 0x%4h",dut.compfart.dp.rf.rf[12]);
      $display("\t+$v1 = 0x%4h",dut.compfart.dp.rf.rf[13]);
      $display("\t+$sp = 0x%4h",dut.compfart.dp.rf.rf[14]);
      $display("\t+$ra = 0x%4h",dut.compfart.dp.rf.rf[15]);
    $display("\t-regfile -- ra1 = %d",dut.compfart.dp.rf.ra1);
    $display("\t-regfile -- ra2 = %d",dut.compfart.dp.rf.ra2);
    $display("\t-regfile -- we3 = %d",dut.compfart.dp.rf.we3);
    $display("\t-regfile -- wa3 = %d",dut.compfart.dp.rf.wa3);
    $display("\t-regfile -- wd3 = %d",dut.compfart.dp.rf.wd3);
    $display("\t-regfile -- rd1 = %d",dut.compfart.dp.rf.rd1);
    $display("\t-regfile -- rd2 = %d",dut.compfart.dp.rf.rd2);
    $display("\t-RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
    $display("\t-PC = %d", dut.compfart.dp.pc);
    $display("\t-memtoreg %h memwrite %h branch %h alusrc %h regdst %h regwrite %h jump %h" , 
      dut.compfart.c.md.memtoreg, dut.compfart.c.md.memwrite, dut.compfart.c.md.branch, dut.compfart.c.md.alusrc
      , dut.compfart.c.md.regdst, dut.compfart.c.md.regwrite, dut.compfart.c.md.jump );
    $display("writedata %h dataadr %h memwrite %h", writedata, dataadr, memwrite);

    if (dut.dmem.RAM[1] === 32'h0C0C000A)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",1,32'h0C0C000A);
        firstTest = 1'b1;
      end
    
    if (dut.dmem.RAM[63] === 0)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",63,0);
        secondTest = 1'b1;
      end
      
    if(memwrite) begin
      if(dataadr === 1 & writedata === 32'h0C0C000A)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",writedata,dataadr);
        firstTest = 1'b1;
      end
    
      if(dataadr === 63 & writedata === 0)
      begin
        $display("Successfully wrote 0x%4h at RAM[%3d]",writedata,dataadr);
        secondTest = 1'b1;
        if(dataadr === 60 & writedata === 28) begin
        $display("Simulation succeeded");
        $finish;
        end
      end

      if (dataadr !== 63) begin
        $display("Simulation failed");
      end
    end
    
    if(dut.compfart.dp.pc > 100)
    begin
      $finish;
    end
    if (firstTest === 1'b1 & secondTest === 1'b1)
    begin
        $display("Program successfully completed");
        #10;
    end
    if (firstTest !== 1'b1)
    begin
        $display("Program test 1 unsuccessful");
        #10;
    end
    if (secondTest !== 1'b1)
    begin
        $display("Program test 2 unsuccessful");
        #10;
    end
    
  end

endmodule

`endif // TB_COMPUTER
