//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              //
//     Create Date: 2024-04-27                                                  //   
//     Module Name: tb_controller                                               //
//     Description: Test bench for a 32-bit RISC-based CPU controller           // 
//                                                                              //
//                                                                              //  
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

`include "./controller.sv"

module tb_controller();
    logic [3:0] op;
    logic [2:0] aluCtrl;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic regWrite, memWrite, pcSrc, zero;

    logic [13:0] control;

    reg clk, reset; //reset for initializing testvectors

    logic [63:0] testvectors[0:1000];
    integer vectornum, errors;

    //expected
    logic [13:0] expectedControl;

    controller uut (
             .op(op),
             .zero(zero),
             .regWrite(regWrite),
             .regDst(regDst),
             .memWrite(memWrite),
             .memToReg(memToReg),
             .jump(jump),
             .aluSrc(aluSrc),
             .pcSrc(pcSrc),
             .aluCtrl(aluCtrl)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end


    initial begin
    $dumpfile("tb_controller.vcd");
    $dumpvars(0, uut);
    
    
    testvectors[0] = {4'b0000, 1'b0, 14'b10100000000010}; // Adjust the value according to your needs
    
    vectornum = 0; 
    errors = 0;
    reset = 1; #27; reset = 0;
    $display("control = {regWrite,regDst,memWrite,memToReg,jump,aluSrc,pcSrc} {aluCtrl}");
end

    always @(negedge clk) begin
        #1;  
        {op, zero, expectedControl} = testvectors[vectornum];
    end

    always @(posedge clk) begin
        #1;
        if (~reset) begin
            control = {
                regWrite,
                regDst,
                memWrite,
                memToReg,
                jump,
                aluSrc,
                pcSrc,
                aluCtrl
                };
            if (control !== expectedControl) begin
                $display("Error:\tinputs: op = %h, zero = %b", op, zero);
                $display("\tcontrol = %b %b, expectedControl = %b %b", control[9:3], control[2:0], expectedControl[9:3], expectedControl[2:0]);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 64'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end


endmodule
