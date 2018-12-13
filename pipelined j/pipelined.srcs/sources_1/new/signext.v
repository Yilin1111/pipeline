`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/12 01:21:53
// Design Name: 
// Module Name: signext
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


module signext (
	input [15:0] a,
	input [5:0] op,
	output [31:0] y
	);
	assign y = (op[3:2]==2'b11) ? {{16{0}}, a} : {{16{a[15]}}, a};
endmodule