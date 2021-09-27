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
	input clk,
	input rst,
    input [5:0] opcode,
    input [5:0] func,
	input Zero,
	input Pos,
	output [1:0]NPCOp,
	output PCWr,
	output IRWr,
	output RFWr,
	output EXTOp,
	output [4:0]ALUOp,
	output DMWr,
	output [1:0]MRFA3Sel,
	output [1:0]MRFWDSel,
	output MALUBsel
    );
	parameter S1 = 3'b001,
			  S2 = 3'b010,
			  S3 = 3'b011,
			  S4 = 3'b100,
			  S5 = 3'b101;
	reg [2:0] current_state = S1, next_state = S1;	// State 
	wire Rtype;
	reg [3:0]delay = 4'd0;
	wire add, addu, sub, subu, and_r, or_r, xor_r, nor_r;
	wire slt, sltu, sll, srl, sra, sllv, srlv, srav, jr;
	wire addi, addiu, andi, ori, xori, sltiu, lui, lw, sw, beq, bne, bgtz;
	wire j, jal;
	//Time period
	wire T1, T2, T3, T4, T5;
	assign T1 = (current_state == S1);
	assign T2 = (current_state == S2);
	assign T3 = (current_state == S3);
	assign T4 = (current_state == S4);
	assign T5 = (current_state == S5);
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
	
	
	assign NPCOp[0] = (beq & Zero & T3) | (bne & ~Zero & T3) | (bgtz & Pos & T3) | (j & T2) | (jal & T2);
	assign NPCOp[1] = (T3 & jr) | (T2 & j) | (T2 & jal);//problem 5
	assign PCWr = T1 | (( j | jal) & T2)| (jr & T3) | (beq & Zero & T3) | (bne & ~Zero & T3) | (bgtz & Pos & T3);//problem 7 PCWr 中beq bne bgtz写错
	assign IRWr = T1;
	assign RFWr = (rst==1)? 0 : ((add|addu|sub|subu|and_r|or_r|xor_r|nor_r|slt|sltu|sll|srl|sra|sllv|srlv|srav|addi|addiu|andi|ori|xori|sltiu|lui) & T4)
				  |(lw & T5)|(jal & T2); //problem 4
	assign EXTOp = (addi|addiu|sltiu|lw|sw) & T2;
	    
	assign ALUOp[0] = T3 & (add|addu|addi|addiu|lw|sw|sub|subu|or_r|nor_r|sltu|srl|srlv|ori|sltiu|lui|beq|bne);
	assign ALUOp[1] = T3 & (and_r|or_r|slt|sltu|sra|sllv|srlv|andi|ori|sltiu|lui);
	assign ALUOp[2] = T3 & (subu|xor_r|nor_r|slt|sltu|sllv|srlv|xori|sltiu|bgtz);
	assign ALUOp[3] = T3 & (subu|sll|srl|sra|sllv|srlv|lui|bgtz);
	assign ALUOp[4] = T3 & (add|addu|addi|addiu|lw|sw|srav);
	assign DMWr = T4 & sw;
	assign MRFA3Sel[0] = T4 & (add|addu|sub|subu|and_r|or_r|xor_r|nor_r|slt|sltu|sll|srl|sra|sllv|srlv|srav);
	assign MRFA3Sel[1] = T2 & jal;
	assign MRFWDSel[0] = T5 & lw;
	assign MRFWDSel[1] = T2 & jal;
	assign MALUBsel = T3 & (addi|addiu|andi|ori|xori|sltiu|lui|lw|sw);

	always @(/* posedge clk*/*) //problem 3持续两个周期的state将时钟沿触发改为*
		begin
			case (current_state)
				S1: begin
						next_state <= S2;
				    end
				S2: begin
						if (j | jal)
							next_state <= S1;
						else next_state <= S3;
					end
				S3: begin
						if (beq | bne | bgtz | jr)
							next_state <= S1;
						else next_state <= S4;
					end
				S4: begin
						if (lw)
							next_state <= S5;
						else next_state <= S1;
					end
				S5: begin
						next_state <= S1;
					end
			     default:next_state <= next_state;
			endcase 
			
		end
	
	always @(posedge clk)
		begin
			if (rst == 1'b1)
			    begin
			        current_state <= S1;
			        //delay <= 4'd0;
			    end
			//else if (delay < 4'd4)
			//    delay <= delay + 4'd1;
			else current_state <= next_state; //阻塞赋值<=
		end
endmodule
