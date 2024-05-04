////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineers: Lamiah Khan and Megan Vo
// 
// Create Date: 2023-02-07
// Module Name: tb_maindec
// Description: Test bench for simple behavioral main decoder
//
// Revision: 1.0
// citation: https://www.ece.ucdavis.edu/~bbaas/281/notes/Handout.verilog6.pdf 
//provided a lot of useful info about this decoder design! 
////////////////////////////////////////////////////////////////////////////////

module tb_maindec();
    logic [3:0] op;
    logic regWrite, branch, memWrite;
    logic [1:0] regDst, memToReg, jump, aluSrc;
    logic [2:0] aluCtrl;

    reg clk, reset;

    logic [71:0] testvectors[0:1000];
    logic [15:0] vectornum, errors;
    logic expectedRegWrite, expectedBranch, expectedMemWrite;
    logic [1:0] expectedRegDst, expectedMemToReg, expectedJump, expectedAluSrc;
    logic [2:0] expectedAluCtrl;


    maindec uut (
             .op(op),
             .regWrite(regWrite),
             .regDst(regDst),
             .branch(branch),
             .memWrite(memWrite),
             .memToReg(memToReg),
             .jump(jump),
             .aluSrc(aluSrc),
             .aluCtrl(aluCtrl)
    );

    always begin
        clk = 1;
        #5;
        clk = 0;
        #5;
    end

    initial begin
        $dumpfile("tb_maindec.vcd");
        $dumpvars(0, uut);

        // Define test vectors directly in the testbench
        // r-type
        testvectors[0]  = {4'b0000, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b010};
        testvectors[1]  = {4'b0001, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b110};
        testvectors[2]  = {4'b0010, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b010};
        testvectors[3]  = {4'b0011, 1'b0, 1'b0, 1'b0, 2'b00, 2'b00, 2'b10, 2'b00, 3'b010};
        testvectors[4]  = {4'b0100, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b000};
        testvectors[5]  = {4'b0101, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b001};
        testvectors[6]  = {4'b0110, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b10, 3'b011};
        testvectors[7]  = {4'b0111, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b10, 3'b101};
        testvectors[8]  = {4'b1000, 1'b1, 1'b0, 1'b1, 2'b00, 2'b00, 2'b00, 2'b00, 3'b111};
        // i-type
        testvectors[9]  = {4'b1001, 1'b0, 1'b0, 1'b0, 2'b10, 2'b00, 2'b00, 2'b00, 3'b110};
        testvectors[10] = {4'b1010, 1'b1, 1'b0, 1'b0, 2'b00, 2'b00, 2'b00, 2'b01, 3'b010};
        testvectors[11] = {4'b1011, 1'b1, 1'b0, 1'b0, 2'b00, 2'b00, 2'b00, 2'b01, 3'b110};
        testvectors[12] = {4'b1100, 1'b1, 1'b0, 1'b0, 2'b00, 2'b01, 2'b00, 2'b01, 3'b010};
        testvectors[13] = {4'b1101, 1'b0, 1'b0, 1'b0, 2'b01, 2'b00, 2'b00, 2'b01, 3'b010};
        // j-type
        testvectors[14] = {4'b1110, 1'b0, 1'b0, 1'b0, 2'b00, 2'b00, 2'b01, 2'b00, 3'b010};
        testvectors[15] = {4'b1111, 1'b1, 1'b1, 1'b0, 2'b00, 2'b10, 2'b01, 2'b00, 3'b010};

        vectornum = 0;
        errors = 0;
        reset = 1; #27; reset = 0;
    end

     always @(posedge clk) begin
        #1;
        {op, expectedRegWrite, expectedRegDst, expectedBranch, expectedMemWrite, expectedMemToReg, expectedJump, expectedAluSrc, expectedAluCtrl} = testvectors[vectornum];
    end

    always @(negedge clk) begin
        if (~reset) begin
            if ({regWrite, regDst, branch, memWrite, memToReg, jump, aluSrc, aluCtrl} !== {expectedRegWrite, expectedRegDst, expectedBranch, expectedMemWrite, expectedMemToReg, expectedJump, expectedAluSrc, expectedAluCtrl}) begin
                $display("Error:\tinput: op %b", op);
                $display("\tcontrol results = %b\n\texpected result = %b", {regWrite, regDst, branch, memWrite, memToReg, jump, aluSrc, aluCtrl}, {expectedRegWrite, expectedRegDst, expectedBranch, expectedMemWrite, expectedMemToReg, expectedJump, expectedAluSrc, expectedAluCtrl});
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 72'hx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
        end
    end
endmodule
