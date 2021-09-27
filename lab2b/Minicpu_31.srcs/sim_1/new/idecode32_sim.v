`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/17 14:00:48
// Design Name: 
// Module Name: idecode32_sim
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


module idecode32_sim(

    );
    //input
    reg clock = 0;
    reg [1:0] WRSel;
    reg [1:0] WDSel;
    reg RFWr;
    reg EXTOp;
    reg [31:0] IM_D;
    reg [31:0] ALUOut;
    reg [31:0] DM_RD;
    reg [15:0] PC_4;
    //output
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire [31:0] Ext;
    wire [31:0] WD;
    wire [31:0] A3;
    
    idecode32(clock, WRSel, WDSel, RFWr, EXTOp, IM_D, ALUOut, DM_RD, PC_4, RD1, RD2, Ext,WD,A3);
    
    always begin
        #10 clock = ~clock;
    end
    initial begin
        #200 begin end
    end
endmodule
