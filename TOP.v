`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 10:30:09
// Design Name: 
// Module Name: TOP
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module TOP(
    input clk,rst,
    output [6:0]LED_out,
    output [3:0]digit,
    output [15:0]max
    );
    
    wire clk_50MHz;
    fiftyMHZ_generator a1(.clk_100MHz(clk),.clk_50MHz(clk_50MHz));

    singlecycle Singlecycle(
        .clk(clk_50MHz), 
        .rst(rst), 
        .max(max)
    );

     seven_segment Seven_segment(
        .clock_100Mhz(clk),
        .reset(rst),
        .displayed_number(max),
        .Anode_Activate(digit),
        .LED_out(LED_out) 
     );
    
endmodule
