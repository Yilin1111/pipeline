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
	output reg [4:0]alucontrol
	);
	always@(*)
	begin
		case (aluop)
			`ALUOP_LW:		begin	alucontrol <= `ALUCONTROL_LW;			end 	//lw,sw,addi实际执行add指令操作
			`ALUOP_ADDIU:	begin	alucontrol <= `ALUCONTROL_ADDIU;		end 	//addiu实际执行addu指令操作
			`ALUOP_BEQ:		begin	alucontrol <= `ALUCONTROL_BEQ;			end 	//beq实际执行sub指令操作
			`ALUOP_ANDI:	begin	alucontrol <= `ALUCONTROL_ANDI;			end 	//andi实际执行and指令操作
			`ALUOP_ORI:		begin	alucontrol <= `ALUCONTROL_ORI;			end 	//ori实际执行or指令操作
			`ALUOP_XORI:	begin	alucontrol <= `ALUCONTROL_XORI;			end 	//xori实际执行xor指令操作
			`ALUOP_SLTI:	begin	alucontrol <= `ALUCONTROL_SLTI;			end 	//slti指令
			`ALUOP_SLTIU:	begin	alucontrol <= `ALUCONTROL_SLTIU;		end 	//sltiu指令
			`ALUOP_LUI:		begin	alucontrol <= `ALUCONTROL_LUI;			end 	//lui指令
			`ALUOP_R_TYPE:	
			case(funct)
				`FUNCT_ADD:		begin	alucontrol <= `ALUCONTROL_ADD;		end 	//add指令
				`FUNCT_SUB:		begin	alucontrol <= `ALUCONTROL_SUB;		end 	//sub指令
				`FUNCT_AND:		begin	alucontrol <= `ALUCONTROL_AND;		end 	//and指令
				`FUNCT_OR:		begin	alucontrol <= `ALUCONTROL_OR;		end 	//or指令
				`FUNCT_XOR:		begin	alucontrol <= `ALUCONTROL_XOR;		end 	//xor指令
				`FUNCT_NOR:		begin	alucontrol <= `ALUCONTROL_NOR;		end 	//nor指令
				`FUNCT_SLT:		begin	alucontrol <= `ALUCONTROL_SLT;		end 	//slt指令
				`FUNCT_SLL:		begin	alucontrol <= `ALUCONTROL_SLL;		end 	//sll指令
				`FUNCT_SRL:		begin	alucontrol <= `ALUCONTROL_SRL;		end 	//srl指令
				`FUNCT_SRA:		begin	alucontrol <= `ALUCONTROL_SRA;		end 	//sra指令
				`FUNCT_SLLV:	begin	alucontrol <= `ALUCONTROL_SLLV;		end 	//sllv指令
				`FUNCT_SRLV:	begin	alucontrol <= `ALUCONTROL_SRLV;		end 	//srlv指令
				`FUNCT_SRAV:	begin	alucontrol <= `ALUCONTROL_SRAV;		end 	//srav指令
				`FUNCT_ADDU:	begin	alucontrol <= `ALUCONTROL_ADDU;		end 	//addu指令
				`FUNCT_SUBU:	begin	alucontrol <= `ALUCONTROL_SUBU;		end 	//subu指令
				`FUNCT_SLTU:	begin	alucontrol <= `ALUCONTROL_SLTU;		end 	//sltu指令
				`FUNCT_MFHI:	begin	alucontrol <= `ALUCONTROL_MFHI;		end 	//mfhi指令
				`FUNCT_MFLO:	begin	alucontrol <= `ALUCONTROL_MFLO;		end 	//mflo指令
				`FUNCT_MTHI:	begin	alucontrol <= `ALUCONTROL_MTHI;		end 	//mthi指令
				`FUNCT_MTLO:	begin	alucontrol <= `ALUCONTROL_MTLO;		end 	//mtlo指令
				`FUNCT_MULT:	begin	alucontrol <= `ALUCONTROL_MULT;		end 	//mult指令
				`FUNCT_MULTU:	begin	alucontrol <= `ALUCONTROL_MULTU;	end 	//multu指令
				`FUNCT_DIV:		begin	alucontrol <= `ALUCONTROL_DIV;		end 	//div指令，但人为打断点的时候由于hilo写使能打开且除法没有算完，hilo被暂时清0覆盖原有值
				`FUNCT_DIVU:	begin	alucontrol <= `ALUCONTROL_DIVU;		end 	//divu指令

				default:		alucontrol <= `ALUCONTROL_AND;	//错误指令
			endcase
			default:	alucontrol <= `ALUCONTROL_AND;		//错误指令
		endcase
	end
endmodule
