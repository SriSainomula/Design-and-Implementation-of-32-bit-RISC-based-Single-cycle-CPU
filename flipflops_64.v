`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2024 16:13:51
// Design Name: 
// Module Name: flipflops_64
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

//64-bit REGISTER

module flipflops_32(D,clk,rst,en,Q);
  input [31:0]D;
  input clk,rst,en;
  output reg [31:0]Q;

    always @(posedge clk)
        begin
            if (rst)
                Q <= 32'b0;
            else if (en)
                Q <= D;
        end
 endmodule
