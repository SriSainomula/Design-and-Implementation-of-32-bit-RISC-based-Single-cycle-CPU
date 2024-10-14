`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2024 16:11:47
// Design Name: 
// Module Name: mux2_64
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

//32-bit 2to1 mux
module mux2_32 (I0,I1,sel,out );

    input [31:0] I0,I1;
    input sel;
    output [31:0]out;
    
    assign out = (sel == 1'b0) ? I0 : I1;

endmodule
