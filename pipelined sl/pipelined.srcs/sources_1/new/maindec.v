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

module maindec(
	input [31:0] instr,
	output reg [9:0] signal,
	output reg [3:0] aluop,
	output wire hilowrite,hilosel,ifhilo
	);
	wire [5:0] op,funct;
	wire [4:0] rt;
	reg [2:0] hilosignal;
	assign {hilowrite,hilosel,ifhilo}=hilosignal;
	assign op=instr[31:26];
	assign funct=instr[5:0];
	assign rt=instr[20:16];
	always@(*)
	begin
		hilosignal <= `HILO_NOT;
		case (op)
			`OP_R_TYPE:	
			begin
				{signal,aluop} <= `INST_CON_R_TYPE;		//R指令
				case(funct)
					`FUNCT_MFHI:	begin		hilosignal <= `HILO_MFHI;				end 	//mfhi指令
					`FUNCT_MFLO:	begin		hilosignal <= `HILO_MFLO;				end 	//mflo指令
					`FUNCT_MTHI:	begin		hilosignal <= `HILO_MTHI;				end 	//mthi指令
					`FUNCT_MTLO:	begin		hilosignal <= `HILO_MTLO;				end 	//mtlo指令
					`FUNCT_MULT:	begin		hilosignal <= `HILO_MULT;				end 	//mult指令
					`FUNCT_MULTU:	begin		hilosignal <= `HILO_MULT;				end 	//multu指令
					`FUNCT_DIV:		begin		hilosignal <= `HILO_MULT;				end 	//div指令，但人为打断点的时候由于hilo写使能打开且除法没有算完，hilo被暂时清0覆盖原有值
					`FUNCT_DIVU:	begin		hilosignal <= `HILO_MULT;				end 	//divu指令
					`FUNCT_JR:		begin		{signal,aluop} <= `INST_CON_JR;			end 	//jr指令
					`FUNCT_JALR:	begin		{signal,aluop} <= `INST_CON_JALR;		end 	//jalr指令
				endcase
			end
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
			//访存指令
			`OP_LW,`OP_LB,`OP_LH:		{signal,aluop} <= `INST_CON_LW;			//有符号扩展访问操作执行lw指令
			`OP_SW,`OP_SB,`OP_SH:		{signal,aluop} <= `INST_CON_SW;			//有符号扩展存储操作执行sw指令
			`OP_LBU:		{signal,aluop} <= `INST_CON_LBU;	//lbu指令
			`OP_LHU:		{signal,aluop} <= `INST_CON_LHU;	//lhu指令			
			//分支跳转指令
			`OP_J:		{signal,aluop} <= `INST_CON_J;			//j指令
			`OP_JAL:	{signal,aluop} <= `INST_CON_JAL;		//jal指令
			`OP_BEQ:	{signal,aluop} <= `INST_CON_BEQ;		//beq指令
			`OP_BNE:	{signal,aluop} <= `INST_CON_BNE;		//bne指令
			`OP_BGTZ:	{signal,aluop} <= `INST_CON_BGTZ;		//bgtz指令
			`OP_BLEZ:	{signal,aluop} <= `INST_CON_BLEZ;		//blez指令
			`OP_BGEZ:											//bgez等指令
			begin
				case (rt)
				`RT_BLTZAL:	{signal,aluop} <= `INST_CON_BLTZAL;
				`RT_BGEZAL:	{signal,aluop} <= `INST_CON_BGEZAL;
					default : {signal,aluop} <= `INST_CON_BGEZ;
				endcase
			end
			//特权指令
			default:	{signal,aluop} <= `INST_CON_ERROR;		//错误指令
		endcase
	end
endmodule
