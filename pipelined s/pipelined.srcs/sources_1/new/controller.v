`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:16:43
// Design Name: 
// Module Name: controller
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


module controller(
	input wire clk,
	input wire rst,
	//decode stage
	input wire [31:0] instrD,
	input equalD,
	output wire pcsrcD,branchD,jumpD,jrD,
	//execute stage
	input wire flushE,stallE,
	output wire memtoregE,alusrcE,regdstE,regwriteE,hilowriteE,hiloselE,ifhiloE,jalE,balE,
	output wire[4:0] alucontrolE,
	//mem stage
	output wire memtoregM,memwriteM,regwriteM,
	//write back stage
	output wire memtoregW,regwriteW
    );
	//wire[5:0] opD,
	wire[5:0] functD;
	assign functD=instrD[5:0];
	//decode stage
	wire[9:0] signal;
	wire[3:0] aluopD;
	wire memtoregD,memwriteD,alusrcD,regdstD,regwriteD,jalD,balD;
	wire hilowriteD,hiloselD,ifhiloD;
	wire[4:0] alucontrolD;
	maindec md(instrD,signal,aluopD,hilowriteD,hiloselD,ifhiloD);
	aludec ad(
			.funct(functD),
			.aluop(aluopD),
			.alucontrol(alucontrolD)
			);
	assign regdstD = signal[0];
	assign regwriteD = signal[1];
	assign memtoregD = signal[2];
	assign memwriteD = signal[3];
	assign alusrcD = signal[4];
	assign branchD = signal[5];
	assign jumpD = signal[6];
	assign jalD = signal[7];
	assign jrD = signal[8];
	assign balD = signal[9];

	assign pcsrcD = branchD & equalD;
	//execute stage
	wire memwriteE;
	//memory stage
	//wire jalM;
	//writeback stage
	//wire jalW;	

	//pipeline registers
	flopenrc #(16) regE(
		clk,
		rst,
		~stallE,flushE,
		{memtoregD,memwriteD,alusrcD,regdstD,regwriteD,hilowriteD,hiloselD,ifhiloD,jalD,balD,alucontrolD},
		{memtoregE,memwriteE,alusrcE,regdstE,regwriteE,hilowriteE,hiloselE,ifhiloE,jalE,balE,alucontrolE}
		);
	flopr #(8) regM(
		clk,rst,
		{memtoregE,memwriteE,regwriteE},
		{memtoregM,memwriteM,regwriteM}
		);
	flopr #(8) regW(
		clk,rst,
		{memtoregM,regwriteM},
		{memtoregW,regwriteW}
		);
endmodule

