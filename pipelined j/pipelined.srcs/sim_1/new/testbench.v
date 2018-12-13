`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:50:30
// Design Name: 
// Module Name: testbench
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


module testbench();
	reg clk;
	reg rst;

	wire [31:0] writedata,dataadr;
	wire memwrite;
	wire [39:0] ascii;
	top dut(clk,rst,writedata,dataadr,memwrite,ascii);

	initial begin 
		rst <= 1;
		#20;
		rst <= 0;
	end

	always begin
		clk <= 1;
		#1;
		clk <= 0;
		#1;
	end
endmodule
