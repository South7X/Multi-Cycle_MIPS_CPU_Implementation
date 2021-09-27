`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/08 11:58:21
// Design Name: 
// Module Name: dmemory32
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


module dmemory32(
    output [31:0] read_data, //从存储器中获得的数据
    input [31:0] address, //ALU.ALUOut
    input [31:0] write_data, //来自译码单元的 RF.RD2
    input Memwrite, //来自控制单元DMWr
    input clock
    );
    wire clk;
    assign clk = ~clock;
    ram ram (
        .clka(clk),
        .wea(Memwrite),
        .addra(address[15:2]),
        .dina(write_data),
        .douta(read_data)
    );
    
endmodule
