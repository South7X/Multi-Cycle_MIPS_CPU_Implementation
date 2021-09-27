`timescale 1ns / 1ps
`include "para.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 15:09:08
// Design Name: 
// Module Name: control32
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



module control32(
	input rst,
    input [5:0] opcode,
    input [5:0] func,
	input Zero,
	input Pos,
	output [1:0]NPCOp,
	output RFWr,
	output EXTOp,
	output [4:0]ALUOp,
	output DMWr,
	output [1:0]WRSel,
	output [1:0]WDsel,
	output Bsel
    );
	wire Rtype;
	wire add, addu, sub, subu, and_r, or_r, xor_r, nor_r;
	wire slt, sltu, sll, srl, sra, sllv, srlv, srav, jr;
	wire addi, addiu, andi, ori, xori, sltiu, lui, lw, sw, beq, bne, bgtz;
	wire j, jal;
	
	//R type
	assign Rtype = (opcode==6'b000000);
	assign add = Rtype & (func==`ADD);
	assign addu = Rtype & (func==`ADDU);
	assign sub = Rtype & (func==`SUB);
	assign subu = Rtype & (func==`SUBU);
	assign and_r = Rtype & (func==`AND);
	assign or_r = Rtype & (func==`OR);
	assign xor_r = Rtype & (func==`XOR);
	assign nor_r = Rtype & (func==`NOR);
	assign slt = Rtype & (func==`SLT);
	assign sltu = Rtype & (func==`SLTU);
	assign sll = Rtype & (func==`SLL);
	assign srl = Rtype & (func==`SRL);
	assign sra = Rtype & (func==`SRA);
	assign sllv = Rtype & (func==`SLLV);
	assign srlv = Rtype & (func==`SRLV);
	assign srav = Rtype & (func==`SRAV);
	assign jr = Rtype & (func==`JR);
	// I type
	assign addi = (opcode==`ADDI);
	assign addiu = (opcode==`ADDIU);
	assign andi = (opcode==`ANDI);
	assign ori = (opcode==`ORI);
	assign xori = (opcode==`XORI);
	assign sltiu = (opcode==`SLTIU);
	assign lui = (opcode==`LUI);
	assign lw = (opcode==`LW);
	assign sw = (opcode==`SW);
	assign beq = (opcode==`BEQ);
	assign bne = (opcode==`BNE);
	assign bgtz = (opcode==`BGTZ);
	//J type
	assign j = (opcode==`J);
	assign jal = (opcode==`JAL);
	
	//NPCOp = 00: PC+4
	//		  01: 满足beq或bne或bgtz条件，PC+4+(signed-extend)offset<<2
	//		  10: jr  
	//		  11: j jal		(zero-extend)address<<2
	assign NPCOp[0] = (beq & Zero) | (bne & ~Zero) | (bgtz & Pos) | j | jal;
	assign NPCOp[1] = jr | j | jal;
	assign RFWr = (rst==1'b1) ? 1'b0 : (add|addu|sub|subu|and_r|or_r|xor_r|nor_r| 
				  				slt|sltu|sll|srl|sra|sllv|srlv|srav|addi|
				  				addiu|andi|ori|xori|sltiu|lui|lw|jal);// final problem change rst
	assign EXTOp = addi|addiu|sltiu|lw|sw;
	//ALUOp = 00000:ADD
	//		  00001:SUB
	//		  00010:AND
	//		  00011:OR
	//		  00100:XOR
	//  	  00101:NOR
	//        00110:SLT
	//		  00111:SLTU
	//		  01000:SLL
	//		  01001:SRL
	//		  01010:SRA
	//		  01011:LUI
	//		  01100:BGTZ
	//        01101:SUBU
	//		  01110:SLLV
	//		  01111:SRLV
	//		  10000:SRAV      
	assign ALUOp[0] = sub|subu|or_r|nor_r|sltu|srl|srlv|ori|sltiu|lui|beq|bne;
	assign ALUOp[1] = and_r|or_r|slt|sltu|sra|sllv|srlv|andi|ori|sltiu|lui;
	assign ALUOp[2] = subu|xor_r|nor_r|slt|sltu|sllv|srlv|xori|sltiu|bgtz;
	assign ALUOp[3] = subu|sll|srl|sra|sllv|srlv|lui|bgtz;
	assign ALUOp[4] = srav;
	assign DMWr = (rst) ? 1'd0 : sw;
	assign WRSel[0] = add|addu|sub|subu|and_r|or_r|xor_r|nor_r| 
				      slt|sltu|sll|srl|sra|sllv|srlv|srav;
	assign WRSel[1] = jal;
	assign WDsel[0] = lw;
	assign WDsel[1] = jal;
	assign Bsel = addi|addiu|andi|ori|xori|sltiu|lui|lw|sw;
endmodule
