`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 23:39:17
// Design Name: 
// Module Name: alu
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

module alu(num1,num2,op,sa,out,hi_o,lo_o,overflow);
	input signed [31:0] num1,num2;
	input [4:0] op,sa;
	output reg [31:0] out,hi_o,lo_o;
	output reg overflow = 0;
	always@(*)
	begin
		case (op)
			`ALUCONTROL_ADD:	begin	
						out = num1+num2;	
						overflow = ~out[31]&num1[31]&num2[31] | out[31]&~num1[31]&~num2[31];	
					end
			`ALUCONTROL_SUB:	begin	
						out = num1-num2;	
						overflow = ~out[31]&num1[31]&~num2[31] | out[31]&~num1[31]&num2[31];	
					end
			`ALUCONTROL_ADDU:	begin	
						out = num1+num2;	
						overflow = ~out[31]&num1[31]&num2[31];	
					end
			`ALUCONTROL_SUBU:	begin	
						out = num1-num2;	
						overflow = out[31]&~num1[31]&num2[31];	
					end
			`ALUCONTROL_SLT:	begin
						out <= 	(~num1[31]&~num2[31]) ? (num1<num2) :
								(num1[31]&num2[31])   ? (num1>num2) :
								(~num1[31]&num2[31])  ? 0 : 1 ;
						overflow<=0;	
					end
			`ALUCONTROL_AND:	begin	out <= num1&num2;														overflow<=0;	end
			`ALUCONTROL_OR:		begin	out <= num1|num2;														overflow<=0;	end		
			`ALUCONTROL_XOR:	begin	out <= num1^num2;														overflow<=0;	end 	//异或
			`ALUCONTROL_NOR: 	begin	out <= ~(num1|num2);													overflow<=0;	end 	//或非
			`ALUCONTROL_LUI: 	begin	out <= {num2[15:0],16'b0}; 												overflow<=0;	end
			`ALUCONTROL_SLTU: 	begin	out <= num1<num2;														overflow<=0;	end
			`ALUCONTROL_SLL: 	begin	out <= num2<<sa;														overflow<=0;	end
			`ALUCONTROL_SRL: 	begin	out <= num2>>sa;														overflow<=0;	end
			`ALUCONTROL_SRA: 	begin	out <= ({32{num2[31]}} << (6'd32-{1'b0,sa})) | num2>>sa;				overflow<=0;	end
			`ALUCONTROL_SLLV: 	begin	out <= num2<<num1[4:0];													overflow<=0;	end
			`ALUCONTROL_SRLV: 	begin	out <= num2>>num1[4:0];													overflow<=0;	end
			`ALUCONTROL_SRAV: 	begin	out <= ({32{num2[31]}} << (6'd32-{1'b0,num1[4:0]})) | num2>>num1[4:0];	overflow<=0;	end
			`ALUCONTROL_MTHI:	begin	hi_o <= num1;															overflow<=0;	end
			`ALUCONTROL_MTLO:	begin	lo_o <= num1;															overflow<=0;	end
			`ALUCONTROL_MULT:	begin	{hi_o,lo_o}<= $signed(num1)*$signed(num2);								overflow<=0;	end
			`ALUCONTROL_MULTU:	begin	{hi_o,lo_o}<= $unsigned(num1)*$unsigned(num2);							overflow<=0;	end
			default:begin 	out <= 32'h00000000;	overflow<=0;	end
		endcase
	end
endmodule
