//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Megan Vo and Lamiah Khan
// 
//     Create Date: 2024-04-27
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// 
// 
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

module alu (
    input logic [15:0] a, b,
    input logic [2:0] ctrl,
    output logic [15:0] result,
    output logic zero
    );
    
    // Define control signals directly in the module
    `define ALU_CTRL_AND 3'b000
    `define ALU_CTRL_OR  3'b001
    `define ALU_CTRL_ADD 3'b010
    `define ALU_CTRL_SLL 3'b011
    `define ALU_CTRL_NOR 3'b100
    `define ALU_CTRL_SRL 3'b101
    `define ALU_CTRL_SUB 3'b110
    `define ALU_CTRL_SLT 3'b111
    
    assign zero = (result == 0);

    always @(a or b or ctrl) begin
        case (ctrl)
            `ALU_CTRL_AND: result <= a & b;     //and
            `ALU_CTRL_OR : result <= a | b;     //or
            `ALU_CTRL_ADD: result <= a + b;     //add
            `ALU_CTRL_SLL: result <= a << b;    //sll
            `ALU_CTRL_NOR: result <= ~(a | b);  //nor
            `ALU_CTRL_SRL: result <= a >> b;    //srl
            `ALU_CTRL_SUB: result <= a - b;     //sub
            `ALU_CTRL_SLT: begin                //slt
                if (a[15] != b[15])
                    result <= (a[15] > b[15]);
                else
                    result <= (a < b);
            end
            default: result <= 0;
        endcase
    end

endmodule

`endif // ALU
