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

module clock #(
    parameter ticks = 10
)(
    //
    // --------------- PORT DEFINITIONS ---------------
    //
    input ENABLE,
    output reg CLOCK
);
    //
    // --------------- MODULE DESIGN IMPLEMENTATION ---------------
    //
    reg start_clock;
    real clock_on = ticks / 2; // Duty cycle = 50%
    real clock_off = ticks / 2;

    // Initialize variables
    initial begin
        CLOCK = 0;
        start_clock = 0;
    end

    always @(posedge ENABLE or negedge ENABLE) begin
        if (ENABLE) begin
            start_clock <= 1;
        end
        else begin
            start_clock <= 0;
        end
        // #ticks CLOCK = ~CLOCK;
    end

    always @ (start_clock) begin
        CLOCK = 0;
        while (start_clock) begin
            #(clock_off) CLOCK = 1;
            #(clock_on) CLOCK = 0;
        end
        CLOCK = 0;
    end
endmodule

`endif // CUSTOM_CLOCK

