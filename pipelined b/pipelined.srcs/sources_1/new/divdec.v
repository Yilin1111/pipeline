`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/12 21:02:10
// Design Name: 
// Module Name: divdec
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

module divdec(
	input [4:0] alucontrol,
	input wire div_ready,
	output reg div_start, div_signed, div_annul
    );

	always @(*) begin
		case (alucontrol)
			`ALUCONTROL_DIV: 
			begin
				if (div_ready)
					{div_start,div_signed,div_annul} = 3'b010;
				else
					{div_start,div_signed,div_annul} = 3'b110;
			end
			`ALUCONTROL_DIVU: 
			begin
				if (div_ready)
					{div_start,div_signed,div_annul} = 3'b000;
				else
					{div_start,div_signed,div_annul} = 3'b100;
			end
			default: {div_start,div_signed,div_annul} = 3'b000;
		endcase
	end
endmodule
