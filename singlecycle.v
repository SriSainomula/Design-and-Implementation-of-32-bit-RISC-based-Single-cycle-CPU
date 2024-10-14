`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2024 20:43:20
// Design Name: 
// Module Name: singlecycle
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


module singlecycle(
        input clk, rst,
        output [15:0]max
    );
    
    wire [31:0] PC;
    wire [31:0]Instruction;
    wire PCSrc, RegWrite, branch, MemtoReg, MemWrite,MemRead, z, g, ALUSrcA, ALUSrcB, lui;
    wire [2:0] ALUControl;
    wire zout,gout;
    wire [6:0]OpCode,Funct7;
    wire [2:0]Funct3;
    wire [31:0]out;
    
    assign OpCode = Instruction[6:0];
    assign Funct7 = Instruction[31:25];
    assign Funct3 = Instruction[14:12];
    assign max = out[15:0];
            
    controller Control_Path(
        .Op(OpCode),
        .funct7(Funct7),
        .funct3(Funct3),
        .RegWrite(RegWrite),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .MemWrite(MemWrite),
        .MemtoReg(MemtoReg),
        .Branch(branch),
        .ALUControl(ALUControl),
        .z(z),
        .g(g),
        .lui(lui)
    );
                      
    datapath Data_Path(
        .clk(clk),
        .rst(rst),
        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .branch(branch),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .lui(lui),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUControl(ALUControl),
        .PC(PC),
        .Instruction(Instruction),
        .out(out),
        .zero(zout),
        .greater_than(gout)
    );
endmodule