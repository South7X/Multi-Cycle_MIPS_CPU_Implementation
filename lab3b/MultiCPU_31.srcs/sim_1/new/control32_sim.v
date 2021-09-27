`timescale 1ns / 1ps
//R type --func
`define ADD 6'b100000
`define ADDU 6'b100001
`define SUB 6'b100010
`define SUBU 6'b100011
`define AND 6'b100100
`define OR 6'b100101
`define XOR 6'b100110
`define NOR 6'b100111
`define SLT 6'b101010
`define SLTU 6'b101011
`define SLL 6'b000000
`define SRL 6'b000010
`define SRA 6'b000011
`define SLLV 6'b000100
`define SRLV 6'b000110
`define SRAV 6'b000111
`define JR 6'b001000
//I type --opcode
`define ADDI 6'b001000
`define ADDIU 6'b001001
`define ANDI 6'b001100
`define ORI 6'b001101
`define XORI 6'b001110
`define SLTIU 6'b001011
`define LUI 6'b001111
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100
`define BNE 6'b000101
`define BGTZ 6'b000111
//J type --opcode
`define J 6'b000010
`define JAL 6'b000011
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/17 10:52:18
// Design Name: 
// Module Name: control32_sim
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


module control32_sim(
    );
    //input
    reg clk = 1'b0;
    reg rst = 1'b1;
    reg [5:0] opcode;
    reg [5:0] func;
	reg Zero;
	reg Pos;
	//output
	wire [1:0]NPCOp;
	wire PCWr;
	wire IRWr;
	wire RFWr;
	wire EXTOp;
	wire [4:0]ALUOp;
	wire DMWr;
	wire [1:0]WRSel;
	wire [1:0]WDsel;
	wire Bsel;
	control32 u_control32(
    //input
    .clk(clk), .rst(rst), .opcode(opcode), .func(func), .Zero(Zero), .Pos(Pos),
    //output
	.NPCOp(NPCOp), .PCWr(PCWr), .IRWr(IRWr), .RFWr(RFWr), .EXTOp(EXTOp), .ALUOp(ALUOp), .DMWr(DMWr), .MRFA3Sel(WRSel), .MRFWDSel(WDsel), .MALUBsel(Bsel)
    );
	
	always #5 clk = ~clk;
	initial begin
	   #500 begin opcode = 5'd0; func = `ADD;rst = 1'b0;end
	   #50 rst = 1'b1;
	  /* #50 begin opcode = 5'd0; func = `ADDU;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `SUB;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `SUBU;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `AND;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `OR;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `XOR;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `NOR;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;*/
	   #10 begin rst = 1'b0;opcode = 5'd0; func = `SLT;end
	   #50 rst = 1'b1;
	   /*#50 begin opcode = 5'd0; func = `SLTU;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;*/
	   #10 begin rst = 1'b0; opcode = 5'd0; func = `SLL;end
	   #50 rst = 1'b1;
	   /*#50 begin opcode = 5'd0; func = `SRL;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `SRA;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `SLLV;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `SRLV;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = 5'd0; func = `SRAV;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;*/
	   #10 begin rst = 1'b0;opcode = 5'd0; func = `JR;end
	   #50 rst = 1'b1;
	   //I TYPE
	   #10 begin rst = 1'b0;opcode = `ADDI;end
	   #50 rst = 1'b1;
	   /* #50 begin opcode = `ADDIU;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = `ANDI;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = `ORI;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = `XORI;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = `SLTIU;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;*/
	   #10 begin rst = 1'b0;opcode = `LUI;end
	   #50 rst = 1'b1;
	   #10 begin rst = 1'b0;opcode = `LW;end
	   #50 rst = 1'b1;
	   #10 begin rst = 1'b0;opcode = `SW;end
	   #50 rst = 1'b1;
	   #10 begin rst = 1'b0;opcode = `BEQ; Zero = 1'b1;end
	   #50 rst = 1'b1; 
	   #10 begin rst = 1'b0; opcode = `BEQ; Zero = 1'b0;end
	   #50 rst = 1'b1;
        /*
	   #50 begin opcode = `BNE; Zero = 1'b1;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = `BNE; Zero = 1'b0;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = `BGTZ; Pos = 1'b1;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;
	   #50 begin opcode = `BGTZ; Pos = 1'b0;end
	   #50 rst = 1'b1;
	   #50 rst = 1'b0;*/
	   //J TYPE
	   #10 begin rst = 1'b0;opcode = `JAL;end
	   #50 rst = 1'b1;
       $finish;
	  // #50 begin opcode = `JAL;end
	end
endmodule
