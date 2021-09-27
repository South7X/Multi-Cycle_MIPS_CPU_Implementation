`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/16 16:05:25
// Design Name: 
// Module Name: para
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

module para(

    );
endmodule
