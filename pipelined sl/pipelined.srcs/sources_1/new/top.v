`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:16:43
// Design Name: 
// Module Name: top
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


module top(
	input wire clk,rst,
	output wire[39:0] ascii
    );
	wire[31:0] pc,instr,readdata,writedata,dataadr;
	wire memen;
	wire [3:0] memwritesel;
	mips mips(clk,rst,pc,instr,memen,memwritesel,dataadr,writedata,readdata);
	inst_mem_2 imem(~clk,pc[31:2],instr);
	data_mem dmem(~clk,memen,memwritesel,dataadr,writedata,readdata);
	instdec mydec(instr,ascii);
endmodule
