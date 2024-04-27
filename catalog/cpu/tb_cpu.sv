`timescale 1ns/100ps

module tb_cpu;

    // Parameters
    parameter n = 32;

    // Inputs
    logic clk = 0;
    logic reset = 0;
    logic [(n-1):0] instr = 0;
    logic [(n-1):0] readdata = 0;

    // Outputs
    logic [(n-1):0] pc;
    logic memwrite;
    logic [(n-1):0] aluout, writedata;

    // Instantiate the CPU
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

    // Clock generator
    always #5 clk = ~clk;

initial begin 
clk=0;
reset=1;
#10;
reset=0;
//zero=0;
readdata = 32'hdeadbeef;
instr = 32'h050C0004;  // lw $12, 4($8)
#10;
$display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
instr=  32'h0C0D000F;  //addi $v1, $zero, 15
#10;
$display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
instr = 32'b00001001100000100000000000000100;  //store word  
#10
 $display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
 instr= 32'b00000101100000110000000000000100;
 //instr= 32'b00001000010011000000000000000100;  //load word
 #10;
 $display("PC = %h", pc);
        $display("ALUOut = %h", aluout);
        $display("WriteData = %h", writedata);
        $display("MemWrite = %d", memwrite);
$finish;
end
    // Send some sample inputs to the CPU
    // initial begin
    //     instr = 32'h050C0004;  // lw $12, 4($8)
    //   $display("PC = %h", pc);
    //     $display("ALUOut = %h", aluout);
    //     $display("WriteData = %h", writedata);
    //     $display("MemWrite = %d", memwrite);
    //     readdata = 32'hdeadbeef;
    //     #100;
    //     $display("PC = %h", pc);
    //     $display("ALUOut = %h", aluout);
    //     $display("WriteData = %h", writedata);
    //     $display("MemWrite = %d", memwrite);
    //     #100;

    //     $finish;
    // end      readdata = 32'h12345678;
    //     #100;
    

endmodule
