`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.09.2024 15:42:33
// Design Name: 
// Module Name: datapath
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


module datapath(
    input clk, rst, PCSrc,  RegWrite, branch, ALUSrcA, ALUSrcB, MemtoReg, MemWrite, MemRead, 
    input z,g,lui,
    input [2:0] ALUControl,
    output [31:0] PC,
    //output [9:0] datamem_addr,
    output [31:0] Instruction,
    output [31:0] out,
    output zero,greater_than
    );
    
    wire [31:0]PCNext, branching_value;
    wire [31:0]ref_out;
    wire [31:0]imm_out;
    wire zero, greater_than;
    wire[9:0] Addr;
    wire [31:0] rs1, rs2, reg_wdata, reg_wdataf, datamem_out;
    wire [31:0] SrcA, SrcB, ALUResult;
    
    
    //Additional Gates we have used in DataPath
    assign datamem_addr= ALUResult[9:0];
    assign out = (rst == 1'b1) ? 64'b0 : ref_out;
    assign branching_value = imm_out;
    assign PCSrc = (branch && zero) || (branch && greater_than); 
    
    
    //Connecting the Various Blocks in Data Path
    
    //PC MUX
    mux2_32 PC_mux(
        .I0(PC + 32'd1), 
        .I1(branching_value),
        .sel(PCSrc),
        .out(PCNext)
    );    

    //PC REGISTER 
    flipflops_32 PCreg(
        .clk(clk),
        .rst(rst),
        .en(1'b1),
        .D(PCNext),
        .Q(PC)
    );  
         
    //INSTRUCTION MEMORY
    Instruction_Memory instruction_memory (
        .a(PC[9:0]),      // input wire [9 : 0] a
        .spo(Instruction)  // output wire [31 : 0] spo
    );
        
    //REGISTER FILE
    Register_File reg_file(
        .clk(clk),
        .rst(rst),
        .write_en(RegWrite),
        .A1(Instruction[19:15]),
        .A2(Instruction[24:20]),
        .A3(Instruction[11:7]),
        .RD1(rs1),
        .RD2(rs2),
        .WD3(reg_wdataf),
        .ref_out(ref_out)
     );
     
     Sign_Extend ImmGen(
        .In(Instruction),
        .Imm_Ext(imm_out)
     );
    
    //MUX A
    mux2_32 muxA(
        .I0(PC), 
        .I1(rs1),
        .sel(ALUSrcA),
        .out(SrcA)
    ); 
          
    //MUX B
    mux2_32 muxB(
        .I0(rs2), 
        .I1(imm_out),
        .sel(ALUSrcB),
        .out(SrcB)
    ); 
    
    //ALU
    ALU ALU(
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .zero_flag(zero),
        .greater_flag(greater_than),
        .ALUResult(ALUResult)
    );
   
   Data_Memory data_memory (
        .a(ALUResult[9:0]),      // input wire [9 : 0] a
        .d(rs2),      // input wire [63 : 0] d
        .clk(clk),  // input wire clk
        .we(MemWrite),    // input wire we
        .spo(datamem_out)  // output wire [63 : 0] spo
    );
    
    //REGISTER FILE WRITE MUX
    mux2_32 reg_mux(
        .I0(ALUResult), 
        .I1(datamem_out),
        .sel(MemtoReg),
        .out(reg_wdata));  
        
   //SELECTING BETWEEN LUI AND REG_WDATA
    mux2_32 lui_mux(
        .I0(reg_wdata), 
        .I1(imm_out),
        .sel(lui),
        .out(reg_wdataf));
        
endmodule

