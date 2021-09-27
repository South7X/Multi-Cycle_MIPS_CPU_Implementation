`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/17 11:31:11
// Design Name: 
// Module Name: ifetc32_sim
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


module ifetc32_sim(

    );
    //input
    reg clock = 0;
    reg rst = 1;
	reg [1:0] NPCOp;
	reg [31:0] RF1; //RF.RD1
	//output
	wire [15:0] PC_4;
    wire [31:0] Instruction;
	//debug
	wire [15:0] PC;
	
	ifetc32 u_ifetc32(clock, rst, NPCOp, RF1,PC_4, Instruction, PC);
	
	always #10 clock = ~clock;
	initial begin
	   #510 begin rst = 0; NPCOp = 2'b00;end
	   #200 begin rst = 1;end
	   #200 begin rst = 0;NPCOp = 2'b01;end
	   #200 begin rst = 1;end
	   #200 begin rst = 0;NPCOp = 2'b10; RF1 = 32'h00000008;end
	   #200 begin rst = 1;end
	   #200 begin rst = 0;NPCOp = 2'b11;end
	end
endmodule
