//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union                                                             //    
// ECE 251 Spring 2024                                                          //
// Engineer: Megan Vo and Lamiah Khan                                           //
//                                                                              // 
//     Create Date: 2024-04-27                                                  // 
//     Module Name: clock                                                       //
//     Description: Clock generator; duty cycle = 50%                           //
//                                                                              //
//                                                                              // 
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
`ifndef CLOCK
`define CLOCK
`timescale 1ns/100ps

module clock (
    input ENABLE,
    output reg CLOCK
    );

    reg start_clock;
    real clock_on = 5;
    real clock_off = 5;

    initial begin
        CLOCK <= 0;
        start_clock <= 0;
    end

    always @(posedge ENABLE or negedge ENABLE) begin
        if (ENABLE) begin
            start_clock = 1;
        end
        else begin
            start_clock = 0;
        end
    end

    always @(start_clock) begin
        CLOCK = 0;
        while (start_clock) begin
            #(clock_off) CLOCK = 1;
            #(clock_on) CLOCK = 0;
        end
        CLOCK = 0;
    end
endmodule

`endif // CLOCK


