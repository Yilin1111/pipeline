`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/22 21:51:20
// Design Name: 
// Module Name: aludec
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
`include "define.vh"

module maindec(op,signal,aluop);
	input [5:0]op;
	output reg [8:0]signal;
	output reg [3:0]aluop;
	//hilowrite,pcsrc,jump,branch,alusrc,__,memwrite,memtoreg,regwrite,regdst,aluop
	always@(*)
	begin
		case (op)
			`OP_R_TYPE:	{signal,aluop} <= `INST_CON_R_TYPE;		//R指令
			//逻辑运算指令
			`OP_ANDI:	{signal,aluop} <= `INST_CON_ANDI;		//andi指令
			`OP_ORI:	{signal,aluop} <= `INST_CON_ORI;		//ori指令
			`OP_XORI:	{signal,aluop} <= `INST_CON_XORI;		//xori指令
			`OP_LUI:	{signal,aluop} <= `INST_CON_LUI;		//lui指令
			//算术运算指令
			`OP_ADDI:	{signal,aluop} <= `INST_CON_ADDI;		//addi指令
			`OP_ADDIU:	{signal,aluop} <= `INST_CON_ADDIU;		//addiu指令
			`OP_SLTI:	{signal,aluop} <= `INST_CON_SLTI;		//slti指令
			`OP_SLTIU:	{signal,aluop} <= `INST_CON_SLTIU;		//sltiu指令
			//分支跳转指令
			`OP_BEQ:	{signal,aluop} <= `INST_CON_BEQ;		//beq指令
			`OP_BNE:	{signal,aluop} <= `INST_CON_BNE;		//bne指令
			`OP_BGTZ:	{signal,aluop} <= `INST_CON_BGTZ;		//bgtz指令
			`OP_BLTZ:	{signal,aluop} <= `INST_CON_BLTZ;		//bltz指令
			`OP_BGEZ:	{signal,aluop} <= `INST_CON_BGEZ;		//bgez指令
			`OP_BLEZ:	{signal,aluop} <= `INST_CON_BLEZ;		//blez指令
			`OP_J:		{signal,aluop} <= `INST_CON_J;			//j指令
			//访存指令
			`OP_LW:		{signal,aluop} <= `INST_CON_LW;			//lw指令
			`OP_SW:		{signal,aluop} <= `INST_CON_SW;			//sw指令
			//特权指令
			default:	{signal,aluop} <= `INST_CON_ERROR;		//错误指令
		endcase
	end
endmodule
