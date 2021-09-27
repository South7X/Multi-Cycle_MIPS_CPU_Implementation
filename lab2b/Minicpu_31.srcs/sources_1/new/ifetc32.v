`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 11:43:10
// Design Name: 
// Module Name: ifetc32
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


module ifetc32(
		input clock,
		input rst,
		input [1:0] NPCOp,
		input [31:0] RF1, //RF.RD1
		output reg [15:0] PC_4,
		output wire [31:0] Instruction,
		//debug
		output [31:0] PC_debug
    );
    reg [15:0] PC;
    reg [15:0] NPC;
    reg flag = 0;
	wire [15:0] offset;
	wire [25:0] address;
	wire [15:0] offset_ext;
	wire [5:0] address_ext = 6'd0;
	wire [15:0] NPC_PC_4;
	//分配 64KB ROM
	prgrom instmem(
		.clka(clock),
		.addra(PC[15:2]),
		.douta(Instruction)
	);
	assign offset = Instruction[15:0];
	assign address = Instruction[25:0];
	assign offset_ext = (offset[15]) ? 16'h0FFFF:16'd0;
	assign PC_debug = {16'h0000, PC};
	assign NPC_PC_4 = PC + 4;
	//NPCOp = 00: PC+4
	//		  01: 满足beq或bne或bgtz条件，PC+4+(signed-extend)offset<<2
	//		  10: jr  
	//		  11: j jal		(zero-extend)address<<2
	always @(*)
	   begin
	       case(NPCOp)
	           2'b00: NPC = NPC_PC_4;
	           2'b01: NPC = NPC_PC_4 + (({offset_ext, offset})<<2);
	           2'b10: NPC = RF1;
	           2'b11: NPC = ({address_ext, address})<<2;
			   default: NPC = NPC;
	       endcase
	   end
	   
	always @(negedge clock)
	   begin
	       PC_4 <= PC + 4; // 维持一个周期jal写入要用
		   if (rst == 1)
		      begin
		          PC <= 15'd0;
		          flag = 0;
		      end
	       else if (flag == 0 && rst == 0)
	           flag = 1;
	       else PC <= NPC;
	   end
	
endmodule
