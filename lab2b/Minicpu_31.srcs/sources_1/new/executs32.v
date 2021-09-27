`timescale 1ns / 1ps
`include "para.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 17:46:07
// Design Name: 
// Module Name: executs32
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

module executs32(
    input rst,
    input [31:0] RF1, //RF.RD1
    input [31:0] RF2, //RF.RD2
    input [31:0] Ext, //EXT.Ext
    input [4:0] shamt,//IM.D[10:6]
    input [4:0] ALUOp,
    input Bsel,
    output Zero,
    output reg Pos,
    output reg [31:0] ALUOut
    );
    wire [31:0] A,B;
    wire [4:0] C;
    assign A = RF1;
    assign B = (Bsel == 0) ? RF2 : Ext;
    assign C = shamt;
    assign Zero = (ALUOut == 0) ? 1:0;
    always @(*)
        begin
            if (rst == 1)
                ALUOut = 31'd0;//≥ı ºªØ
            case (ALUOp)
                `ADD_u: ALUOut = A + B;
                `SUB_u: ALUOut = $signed(A) -$signed(B);
                `SUBU_u: ALUOut = A - B;
                `AND_u: ALUOut = A & B;
                `OR_u:  ALUOut = A | B;
                `XOR_u: ALUOut = A ^ B;
                `NOR_u: ALUOut = ~(A | B);
                `SLT_u: ALUOut = ($signed(A)<$signed(B)) ? 1:0;
                `SLTU_u: ALUOut = (A < B) ? 1:0;
                `SLL_u: ALUOut = B << C;
                `SRL_u: ALUOut = B >> C;
                `SRA_u: ALUOut = $signed(B) >>> C;
                `SLLV_u: ALUOut = B << A;
                `SRLV_u: ALUOut = B >> A;
                `SRAV_u: ALUOut = $signed(B) >>> A;
                `LUI_u: ALUOut = (B << 16) & 32'h0FFFF0000;
                `BGTZ_u: Pos = ($signed(A) > 0) ? 1:0;
            endcase    
        end
endmodule
