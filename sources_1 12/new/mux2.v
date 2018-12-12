`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/12 01:34:15
// Design Name: 
// Module Name: mux2
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


module mux2 # (parameter WIDTH = 32)(
	input [WIDTH-1:0] in1,
	input [WIDTH-1:0] in2,
	input sel,
	output [WIDTH-1:0] out
    );
	assign out = (sel == 0)? in1 : in2 ;
endmodule