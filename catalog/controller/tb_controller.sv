//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //   
//     Module Name: tb_controller                                               //
//     Description: Test bench for a single-cycle MIPS computer                 // 
//                                                                              //
//                                                                              //  
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps
`include "controller.sv"

module controller_tb;
    reg [5:0] op, funct;
    reg zero;

    wire memwrite;
    wire pcsrc, alusrc;
    wire regwrite;
    wire [1:0] jump, regdst, memtoreg;
    wire [2:0] alucontrol;

    // Instantiate Controller module
    controller #(.n(32)) dut (
        .op(op),
        .funct(funct),
        .zero(zero),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol)
    );
    
    initial begin
        op = 6'b000000;
        funct = 6'b000000;
        zero = 0;

        #10;

        // Case 1: Test case description
        op = 6'b001000;
        funct = 6'b000010;
        zero = 1;
        #10;
        $display("regwrite = %b", regwrite);
        $display("regdst = %b", regdst);
        $display("alusrc = %b", alusrc);
        $display("branch = %b", pcsrc);
        $display("memwrite = %b", memwrite);
        $display("memtoreg = %b", memtoreg);
        $display("jump = %b", jump);
        $display("alucontrol = %b", alucontrol);

        // Case 2: Test case description
        op = 6'b000000;
        funct = 6'b000100;
        zero= 1;
        #10;
        $display("regwrite = %b", regwrite);
        $display("regdst = %b", regdst);
        $display("alusrc = %b", alusrc);
        $display("branch = %b", pcsrc);
        $display("memwrite = %b", memwrite);
        $display("memtoreg = %b", memtoreg);
        $display("jump = %b", jump);
        $display("alucontrol = %b", alucontrol);
    
        #100 $finish;
    end
endmodule
