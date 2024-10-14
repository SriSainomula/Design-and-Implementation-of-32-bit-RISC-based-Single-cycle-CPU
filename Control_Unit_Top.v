`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2024 23:05:13
// Design Name: 
// Module Name: Control_Unit_Top
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

module controller(
        input [6:0]Op,funct7,
        input [2:0]funct3,
        output RegWrite,ALUSrcA,ALUSrcB,MemWrite,MemtoReg,Branch,
        output [2:0]ALUControl,
        output z,g,lui
    );

    wire [1:0]ALUOp;

    Main_Decoder Main_Decoder(
                .Op(Op),
                .RegWrite(RegWrite),
                .MemWrite(MemWrite),
                .MemRead(MemRead),
                .MemtoReg(MemtoReg),
                .Branch(Branch),
                .ALUSrcA(ALUSrcA),
                .ALUSrcB(ALUSrcB),
                .ALUOp(ALUOp),
                .lui(lui)
    );

    ALU_Decoder ALU_Decoder(
                 .ALUOp(ALUOp),
                 .funct3(funct3),
                 .funct7(funct7),
                 .op(Op),
                 .ALUControl(ALUControl),
                 .z(z),
                 .g(g)
    );


endmodule
