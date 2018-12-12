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

module aludec(
	input [5:0]funct,
	input [3:0]aluop,
	output reg [4:0]alucontrol,
	output hilowrite,
	output hilosel,
	output ifhilo
	);
	reg [2:0] hilosignal;
	assign {hilowrite,hilosel,ifhilo}=hilosignal;
	always@(*)
	begin
		case (aluop)
			`ALUOP_LW:		begin	alucontrol <= `ALUCONTROL_LW;			hilosignal <= `HILO_NOT;		end 	//lw,sw,addi实际执行add指令操作
			`ALUOP_ADDIU:	begin	alucontrol <= `ALUCONTROL_ADDIU;		hilosignal <= `HILO_NOT;		end 	//addiu实际执行addu指令操作
			`ALUOP_BEQ:		begin	alucontrol <= `ALUCONTROL_BEQ;			hilosignal <= `HILO_NOT;		end 	//beq实际执行sub指令操作
			`ALUOP_ANDI:	begin	alucontrol <= `ALUCONTROL_ANDI;			hilosignal <= `HILO_NOT;		end 	//andi实际执行and指令操作
			`ALUOP_ORI:		begin	alucontrol <= `ALUCONTROL_ORI;			hilosignal <= `HILO_NOT;		end 	//ori实际执行or指令操作
			`ALUOP_XORI:	begin	alucontrol <= `ALUCONTROL_XORI;			hilosignal <= `HILO_NOT;		end 	//xori实际执行xor指令操作
			`ALUOP_SLTI:	begin	alucontrol <= `ALUCONTROL_SLTI;			hilosignal <= `HILO_NOT;		end 	//slti指令
			`ALUOP_SLTIU:	begin	alucontrol <= `ALUCONTROL_SLTIU;		hilosignal <= `HILO_NOT;		end 	//sltiu指令
			`ALUOP_LUI:		begin	alucontrol <= `ALUCONTROL_LUI;			hilosignal <= `HILO_NOT;		end 	//lui指令
			`ALUOP_R_TYPE:	
			case(funct)
				`FUNCT_ADD:		begin	alucontrol <= `ALUCONTROL_ADD;		hilosignal <= `HILO_NOT;		end 	//add指令
				`FUNCT_SUB:		begin	alucontrol <= `ALUCONTROL_SUB;		hilosignal <= `HILO_NOT;		end 	//sub指令
				`FUNCT_AND:		begin	alucontrol <= `ALUCONTROL_AND;		hilosignal <= `HILO_NOT;		end 	//and指令
				`FUNCT_OR:		begin	alucontrol <= `ALUCONTROL_OR;		hilosignal <= `HILO_NOT;		end 	//or指令
				`FUNCT_XOR:		begin	alucontrol <= `ALUCONTROL_XOR;		hilosignal <= `HILO_NOT;		end 	//xor指令
				`FUNCT_NOR:		begin	alucontrol <= `ALUCONTROL_NOR;		hilosignal <= `HILO_NOT;		end 	//nor指令
				`FUNCT_SLT:		begin	alucontrol <= `ALUCONTROL_SLT;		hilosignal <= `HILO_NOT;		end 	//slt指令
				`FUNCT_SLL:		begin	alucontrol <= `ALUCONTROL_SLL;		hilosignal <= `HILO_NOT;		end 	//sll指令
				`FUNCT_SRL:		begin	alucontrol <= `ALUCONTROL_SRL;		hilosignal <= `HILO_NOT;		end 	//srl指令
				`FUNCT_SRA:		begin	alucontrol <= `ALUCONTROL_SRA;		hilosignal <= `HILO_NOT;		end 	//sra指令
				`FUNCT_SLLV:	begin	alucontrol <= `ALUCONTROL_SLLV;		hilosignal <= `HILO_NOT;		end 	//sllv指令
				`FUNCT_SRLV:	begin	alucontrol <= `ALUCONTROL_SRLV;		hilosignal <= `HILO_NOT;		end 	//srlv指令
				`FUNCT_SRAV:	begin	alucontrol <= `ALUCONTROL_SRAV;		hilosignal <= `HILO_NOT;		end 	//srav指令
				`FUNCT_ADDU:	begin	alucontrol <= `ALUCONTROL_ADDU;		hilosignal <= `HILO_NOT;		end 	//addu指令
				`FUNCT_SUBU:	begin	alucontrol <= `ALUCONTROL_SUBU;		hilosignal <= `HILO_NOT;		end 	//subu指令
				`FUNCT_SLTU:	begin	alucontrol <= `ALUCONTROL_SLTU;		hilosignal <= `HILO_NOT;		end 	//sltu指令
				`FUNCT_MFHI:	begin	alucontrol <= `ALUCONTROL_MFHI;		hilosignal <= `HILO_MFHI;		end 	//mfhi指令
				`FUNCT_MFLO:	begin	alucontrol <= `ALUCONTROL_MFLO;		hilosignal <= `HILO_MFLO;		end 	//mflo指令
				`FUNCT_MTHI:	begin	alucontrol <= `ALUCONTROL_MTHI;		hilosignal <= `HILO_MTHI;		end 	//mthi指令
				`FUNCT_MTLO:	begin	alucontrol <= `ALUCONTROL_MTLO;		hilosignal <= `HILO_MTLO;		end 	//mtlo指令
				`FUNCT_MULT:	begin	alucontrol <= `ALUCONTROL_MULT;		hilosignal <= `HILO_MULT;		end 	//mult指令
				`FUNCT_MULTU:	begin	alucontrol <= `ALUCONTROL_MULTU;	hilosignal <= `HILO_MULT;		end 	//multu指令

				default:		alucontrol <= `ALUCONTROL_AND;	//错误指令
			endcase
			default:	alucontrol <= `ALUCONTROL_AND;		//错误指令
		endcase
	end
endmodule
