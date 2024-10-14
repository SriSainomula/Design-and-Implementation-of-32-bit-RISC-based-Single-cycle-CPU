`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 12:04:10
// Design Name: 
// Module Name: singlecycle_test
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


module singlecycle_test();

    reg clk,rst;
    wire [15:0]max;

    parameter CLOCK_PERIOD=20; //20ns Time Period
    
    //Module used for Testing
    singlecycle test(.clk(clk),.rst(rst),.max(max));

    //Testing
    initial begin
        clk=1'b0;
        rst=1'b1;
        //change the reset signal
        #35 rst=0;
        
    end

    //System Clock Generation
    always begin
        //After delay of Clockperiod/2 we are inverting clock
        #(CLOCK_PERIOD/2) clk=~clk;
    end

endmodule
