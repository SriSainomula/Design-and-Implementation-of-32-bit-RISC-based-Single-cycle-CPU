module ALU (SrcA, SrcB, ALUControl, zero_flag, greater_flag, ALUResult);
   
    input [31:0] SrcA, SrcB;
    input [2:0]  ALUControl;
    output zero_flag, greater_flag;
    output reg [31:0] ALUResult;

    assign zero_flag = (ALUResult== 32'h00000000) ? 1'b1 : 1'b0; // Zero Flag
    assign greater_flag = (ALUResult[31] == 1'b0) ? 1'b1 : 1'b0; // Greater Flag 
    //[We will perform SrcA - SrcB, if Result is +ve it means SrcA is greater than SrcB 
    //                              else if Result is -ve it means SrcA is less than SrcB

    always @(*)
        begin
            case (ALUControl)
                3'b000: // ADD
                    ALUResult = SrcA + SrcB;
                3'b001: // SUB
                    ALUResult = SrcA + (~SrcB) + 1'b1;
                3'b010: // AND
                    ALUResult = SrcA & SrcB;
                3'b011: // OR
                    ALUResult = SrcA | SrcB;
                3'b100: // XOR
                    ALUResult = SrcA ^ SrcB;
                default:
                    ALUResult = 32'b0;
            endcase
        end

endmodule