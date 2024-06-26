//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //
// ECE 251 Spring 2024                                                          //
// Engineers: Megan Vo and Lamiah Khan                                          //
//                                                                              //
//     Create Date: 2024-04-27                                                  //
//     Module Name: tb_aludec                                                   //
//     Description: Testbench for aludec                                        //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/100ps

module aludec_tb;


  reg [5:0] funct;
  reg [1:0] aluop;
  wire [2:0] alucontrol;


  aludec #(.n(32)) dut (
    .funct(funct),
    .aluop(aluop),
    .alucontrol(alucontrol)
  );

 
  initial begin
    // Initialize inputs
    funct = 6'b000000;
    aluop = 2'b00;

    // Wait for a few clock cycles
    #10;

    // Test case 1
    funct = 6'b000011;
    aluop = 2'b10;
    #5; // Wait for output stabilization
    $display("ALU Control: %b", alucontrol);

    // Test case 2
    funct = 6'b000100;
    aluop = 2'b10;
    #5; // Wait for output stabilization
    $display("ALU Control: %b", alucontrol);

    // Test case 3
    funct = 6'b000000;
    aluop = 2'b10;
    #5; // Wait for output stabilization
    $display("ALU Control: %b", alucontrol);

    #100 $finish;
  end

endmodule

