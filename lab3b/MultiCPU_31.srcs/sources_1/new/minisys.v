`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 11:22:49
// Design Name: 
// Module Name: minisys
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


module minisys(
    input rst,
    input clk,
    output [31:0] debug_wb_pc,      //PC reg
    output debug_wb_rf_wen,  //RFwr
    output [31:0] debug_wb_rf_wnum, //A3
    output [31:0] debug_wb_rf_wdata //WD
    );
    wire clock;
    wire [31:0] IR, DM_RD, ALUOut, RF1, RF2, Ext;
    wire [15:0] PC_4;
    wire [4:0] ALUOp;
    wire [1:0] NPCOp, WRSel, WDSel;
    wire Zero, Pos, RFWr, EXTOp, DMWr, Bsel, PCWr, IRWr;
    //debug signals
    //wire [31:0] debug_wb_pc;      //PC reg
    //wire        debug_wb_rf_wen;  //RFwr
    //wire [31:0] debug_wb_rf_wnum; //A3
    //wire [31:0] debug_wb_rf_wdata;//WD

    assign debug_wb_rf_wen = RFWr;

    cpuclk cc(.clk_in1(clk), .clk_out1(clock));

    control32 cu(
    //input
    .clk(clock), .rst(rst), .opcode(IR[31:26]), .func(IR[5:0]), .Zero(Zero), .Pos(Pos),
    //output
	.NPCOp(NPCOp), .PCWr(PCWr), .IRWr(IRWr), .RFWr(RFWr), .EXTOp(EXTOp), .ALUOp(ALUOp), .DMWr(DMWr), .MRFA3Sel(WRSel), .MRFWDSel(WDSel), .MALUBsel(Bsel)
    );

    dmemory32 dm(
    .DM_RD(DM_RD), //output
    .address(ALUOut), .write_data(RF2), .Memwrite(DMWr), .clock(clock)//input
    );

    executs32 exe(
    //input
    .clk(clock), .rst(rst), .RF1(RF1), .RF2(RF2), .Ext(Ext), .shamt(IR[10:6]), .ALUOp(ALUOp), .Bsel(Bsel),
    //output 
    .Zero(Zero), .Pos(Pos), .ALUOut(ALUOut)
    );

    idecode32 dec(
    //input
    .rst(rst), .clock(clock), .WRSel(WRSel), .WDSel(WDSel), .RFWr(RFWr), .EXTOp(EXTOp), .IM_D(IR), .ALUOut(ALUOut), .DM_RD(DM_RD), .PC_4(PC_4),
    //output
    .RD1(RF1), .RD2(RF2), .Ext(Ext), 
    //debug
    .debug_WD(debug_wb_rf_wdata), .debug_A3(debug_wb_rf_wnum)
    );

    ifetc32 ifetc(
        //input
		.clock(clock), .rst(rst), .NPCOp(NPCOp), .PCWr(PCWr), .IRWr(IRWr), .RF1(RF1), 
        //output
		.PC_4(PC_4), .IR(IR),
        //debug
		.PC_debug(debug_wb_pc)
    );
endmodule
