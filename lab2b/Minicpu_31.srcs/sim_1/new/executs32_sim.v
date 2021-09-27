`timescale 1ns / 1ps
//--------------ALU-----------
`define ADD_u 5'b00000
`define SUB_u 5'b00001
`define AND_u 5'b00010
`define OR_u 5'b00011
`define XOR_u 5'b00100
`define NOR_u 5'b00101
`define SLT_u 5'b00110
`define SLTU_u 5'b00111
`define SLL_u 5'b01000
`define SRL_u 5'b01001
`define SRA_u 5'b01010
`define LUI_u 5'b01011
`define BGTZ_u 5'b01100
`define SUBU_u 5'b01101
`define SLLV_u 5'b01110
`define SRLV_u 5'b01111
`define SRAV_u 5'b10000
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/17 12:10:37
// Design Name: 
// Module Name: executs32_sim
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


module executs32_sim(

    );
    //input
    reg [31:0] RF1;
    reg [31:0] RF2;
    reg [31:0] Ext;
    reg [4:0] shamt;
    reg [4:0] ALUOp;
    reg Bsel;
    //output
    wire Zero;
    wire Pos;
    wire [31:0] ALUOut;
    
    executs32 u_execut32( RF1, RF2, Ext, shamt, ALUOp, Bsel, Zero, Pos, ALUOut);
    
    initial begin
        #200 begin 
                   ALUOp = `ADD_u; 
                   RF1 = 32'h00000002; 
                   RF2 = 32'h00000001; 
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `SUB_u; 
                   RF1 = 32'hfffffffd; //-3 
                   RF2 = 32'hffffffff; //-1
                   Bsel = 0;
                   //-3 - -1 = 2, Zero = 0 
             end
        #200 begin 
                   ALUOp = `SUB_u; 
                   RF1 = 32'hffffffff; //-1 
                   RF2 = 32'hffffffff; //-1
                   Bsel = 0;
                   //-1 - -1 = 0, Zero = 1 
             end
        #200 begin 
                   ALUOp = `SUBU_u; 
                   RF1 = 32'hffffffff; 
                   RF2 = 32'hfffffffe; // ans = 1 
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `AND_u; 
                   RF1 = 32'h0000000A; //1010
                   RF2 = 32'h00000009; //1001 ans = 1000 (8)
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `OR_u; 
                   RF1 = 32'h0000000A; //1010
                   RF2 = 32'h00000009; //1001 ans = 1011 (B)
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `XOR_u; 
                   RF1 = 32'h0000000A; //1010
                   RF2 = 32'h00000009; //1001 ans = 0011 (3)
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `NOR_u; 
                   RF1 = 32'h0000000A; //1010
                   RF2 = 32'h00000009; //1001 ans = 0100 (4)
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `SLT_u; 
                   RF1 = 32'hffffffff; //-1
                   RF2 = 32'h00000001; //1, ans = 1 (<)
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `SLTU_u; 
                   RF1 = 32'hffffffff; //
                   RF2 = 32'h00000001; //1, ans = 0 (>)
                   Bsel = 0;
             end
        #200 begin 
                   ALUOp = `SLL_u; 
                   RF2 = 32'h00000001; 
                   shamt = 5'b00010; // 0001 << 2  ans =  0004H
             end
        #200 begin 
                   ALUOp = `SRL_u; 
                   RF2 = 32'h80000008; 
                   shamt = 5'b00010; //  >> 2  ans = 2000 0002H
             end
        #200 begin 
                   ALUOp = `SRA_u; 
                   RF2 = 32'h80000008; 
                   shamt = 5'b00010; //  >>> 2  ans = e000 0002H
             end
        #200 begin 
                   ALUOp = `SLLV_u; 
                   RF2 = 32'h00000001; 
                   RF1 = 32'h00000002; // 0001 << 2  ans =  0004H
             end
        #200 begin 
                   ALUOp = `SRLV_u; 
                   RF2 = 32'h80000008; 
                   RF1 = 32'h00000002; //  >> 2  ans = 2000 0002H
             end
        #200 begin 
                   ALUOp = `SRAV_u; 
                   RF2 = 32'h80000008; 
                   RF1 = 32'h00000002; //  >>> 2  ans = e000 0002H
             end
         #200 begin 
                   ALUOp = `ADD_u;  //addi
                   RF1 = 32'h00000002; 
                   Ext = 32'h00000001; //ans = 3
                   Bsel = 1;
             end
         #200 begin 
                   ALUOp = `AND_u;  //andi
                   RF1 = 32'h0000000A; //1010
                   Ext = 32'h00000009; //1001 ans = 1000 (8)
                   Bsel = 1;
             end
        #200 begin 
                   ALUOp = `OR_u; //ori
                   RF1 = 32'h0000000A; //1010
                   Ext = 32'h00000009; //1001 ans = 1011 (B)
                   Bsel = 1;
             end
        #200 begin 
                   ALUOp = `XOR_u; //xori
                   RF1 = 32'h0000000A; //1010
                   Ext = 32'h00000009; //1001 ans = 0011 (3)
                   Bsel = 1;
             end
        #200 begin 
                   ALUOp = `SLTU_u; //sltui
                   RF1 = 32'hffffffff; //
                   Ext = 32'h00000001; //1, ans = 0 (>)
                   Bsel = 1;
             end
        #200 begin 
                   ALUOp = `LUI_u; 
                   Ext = 32'h00000002; //   ans = 0002 0000 H
                   Bsel = 1;
             end
        #200 begin 
                   ALUOp = `BGTZ_u; 
                   RF1 = 32'hffffffff; //  Pos = 0
             end
        #200 begin 
                   ALUOp = `BGTZ_u; 
                   RF1 = 32'h00000001; //  Pos = 1
             end
    end
endmodule
