`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:19:03
// Design Name: 
// Module Name: mips
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


module mips(
	input wire clk,rst,
	output wire[31:0] pcF,
	input wire[31:0] instrF,
	output wire memwriteM,
	output wire[31:0] aluoutM,writedataM,
	input wire[31:0] readdataM 
    );
	
	//wire [5:0] opD,functD;
	wire [31:0] instrD;
	wire [4:0] alucontrolE;
	wire regdstE,alusrcE,pcsrcD,branchD,jumpD,jrD,balE,jalE,memtoregE,memtoregM,memtoregW,
			regwriteE,regwriteM,regwriteW,hilowriteE,hiloselE,ifhiloE,flushE,stallE,equalD,overflowE;

	controller c(
		.clk(clk),
		.rst(rst),
		//decode stage
		.instrD(instrD),
		.equalD(equalD),
		.pcsrcD(pcsrcD),
		.branchD(branchD),
		.jumpD(jumpD),
		.jrD(jrD),

		//execute stage
		.flushE(flushE),
		.stallE(stallE),
		.memtoregE(memtoregE),
		.alusrcE(alusrcE),
		.regdstE(regdstE),
		.regwriteE(regwriteE),
		.hilowriteE(hilowriteE),
		.hiloselE(hiloselE),
		.ifhiloE(ifhiloE),
		.jalE(jalE),
		.balE(balE),
		.alucontrolE(alucontrolE),
		//mem stage
		.memtoregM(memtoregM),
		.memwriteM(memwriteM),
		.regwriteM(regwriteM),

		//write back stage
		.memtoregW(memtoregW),
		.regwriteW(regwriteW)
		
		);

	datapath dp(
		.clk(clk),
		.rst(rst),
		//fetch stage
		.pcF(pcF),
		.instrF(instrF),
		//decode stage
		.pcsrcD(pcsrcD),
		.branchD(branchD),
		.jumpD(jumpD),
		.jrD(jrD),
		.equalD(equalD),

		.instrD(instrD),
		//execute stage
		.memtoregE(memtoregE),
		.alusrcE(alusrcE),
		.regdstE(regdstE),
		.regwriteE(regwriteE),
		.hilowriteE(hilowriteE),
		.hiloselE(hiloselE),
		.ifhiloE(ifhiloE),
		.jalE(jalE),
		.balE(balE),
		.alucontrolE(alucontrolE),
		.flushE(flushE),
		.stallE(stallE),
		.overflowE(overflowE),
		//mem stage
		.memtoregM(memtoregM),
		.regwriteM(regwriteM),
		.aluoutM(aluoutM),
		.writedataM(writedataM),
		.readdataM(readdataM),
		//writeback stage
		.memtoregW(memtoregW),
		.regwriteW(regwriteW)
	    );
	
endmodule