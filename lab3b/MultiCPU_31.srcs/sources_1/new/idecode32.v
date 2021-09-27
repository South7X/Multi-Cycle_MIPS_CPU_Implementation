`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 17:07:43
// Design Name: 
// Module Name: idecode32
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


module idecode32(
    input clock,
    input rst,
    input [1:0] WRSel,
    input [1:0] WDSel,
    input RFWr,
    input EXTOp,
    input [31:0] IM_D,
    input [31:0] ALUOut,
    input [31:0] DM_RD,
    input [15:0] PC_4,
    output reg [31:0] RD1,
    output reg [31:0] RD2,
    output reg [31:0] Ext,
    //debug
    output wire [31:0] debug_WD,
    output wire [31:0] debug_A3
    );
    wire [4:0] A1, A2;
    wire [15:0] sign_ext;
    wire [15:0] zero_ext = 16'd0;
    reg [31:0] RF[0:31];//寄存器组
    reg [31:0] WD, A3;
    reg [15:0] WD_PC_4;
    assign debug_WD = WD;
    assign debug_A3 = A3;
    assign A1 = IM_D[25:21];
    assign A2 = IM_D[20:16];
    assign sign_ext = (IM_D[15]) ? 16'h0FFFF : 16'd0;
    always @(*)
        begin
            case (WRSel)
                2'b00: A3 = IM_D[20:16];
                2'b01: A3 = IM_D[15:11];
                2'b10: A3 = 5'b11111;
            endcase
            case (WDSel)
                2'b00: WD = ALUOut;
                2'b01: WD = DM_RD;
                2'b10: WD = WD_PC_4;//problem 6
            endcase
           // debug_WD = WD;
           // debug_A3 = A3;
            
        end
    always @(posedge clock)
        begin
			RD1 <= RF[A1];
		    RD2 <= RF[A2];
		    Ext <= (EXTOp) ? {sign_ext, IM_D[15:0]} : {zero_ext, IM_D[15:0]};
			WD_PC_4 <= PC_4;//PC_4维持一个周期 problem 6
            if (rst == 1)
                begin
                    RF[0] <= 32'd0;RF[1] <= 32'd0;RF[2] <= 32'd0;RF[3] <= 32'd0;RF[4] <= 32'd0;RF[5] <= 32'd0;RF[6] <= 32'd0;RF[7] <= 32'd0;
                    RF[8] <= 32'd0;RF[9] <= 32'd0;RF[10] <= 32'd0;RF[11] <= 32'd0;RF[12] <= 32'd0;RF[13] <= 32'd0;RF[14] <= 32'd0;RF[15] <= 32'd0;
                    RF[16] <= 32'd0;RF[17] <= 32'd0;RF[18] <= 32'd0;RF[19] <= 32'd0;RF[20] <= 32'd0;RF[21] <= 32'd0;RF[22] <= 32'd0;RF[23] <= 32'd0;
                    RF[24] <= 32'd0;RF[25] <= 32'd0;RF[26] <= 32'd0;RF[27] <= 32'd0;RF[28] <= 32'd0;RF[29] <= 32'd0;RF[30] <= 32'd0;RF[31] <= 32'd0;
                end
           // if (WDSel == 2'b10)//problem 6
			//    WD <= PC_4;
            if (RFWr == 1)
                begin
                    RF[A3] <= WD;
                   //   //problem 4
			       // 
			    end
        end
endmodule
