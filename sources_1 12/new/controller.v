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
	input wire[5:0] opD,
	input wire[5:0] functD,
	input equalD,
	output wire pcsrcD,branchD,jumpD,
	//execute stage
	input wire flushE,
	output wire memtoregE,alusrcE,regdstE,regwriteE,hilowriteE,hiloselE,ifhiloE,	
	output wire[4:0] alucontrolE,
	//mem stage
	output wire memtoregM,memwriteM,regwriteM,
	//write back stage
	output wire memtoregW,regwriteW
    );
	//decode stage
	wire[8:0] signal;
	wire[3:0] aluopD;
	wire memtoregD,memwriteD,alusrcD,regdstD,regwriteD;
	wire hilowriteD,hiloselD,ifhiloD;
	//wire [2:0] hilosignalD;
	wire[4:0] alucontrolD;
	//execute stage
	wire memwriteE;

	maindec md(opD,signal,aluopD);
	aludec ad(
			.funct(functD),
			.aluop(aluopD),
			.alucontrol(alucontrolD),
			.hilowrite(hilowriteD),
			.hilosel(hiloselD),
			.ifhilo(ifhiloD)
			);
	assign memtoregD = signal[2];
	assign memwriteD = signal[3];
	assign alusrcD = signal[4];
	assign regdstD = signal[0];
	assign regwriteD = signal[1];
	assign jumpD = signal[6];
	assign branchD = signal[5];
	assign pcsrcD = branchD & equalD;

	//pipeline registers
	floprc #(16) regE(
		clk,
		rst,
		flushE,
		{memtoregD,memwriteD,alusrcD,regdstD,regwriteD,hilowriteD,hiloselD,ifhiloD,alucontrolD},
		{memtoregE,memwriteE,alusrcE,regdstE,regwriteE,hilowriteE,hiloselE,ifhiloE,alucontrolE}
		);
	flopr #(8) regM(
		clk,rst,
		{memtoregE,memwriteE,regwriteE,hilowriteE},
		{memtoregM,memwriteM,regwriteM,hilowriteM}
		);
	flopr #(8) regW(
		clk,rst,
		{memtoregM,regwriteM,hilowriteM},
		{memtoregW,regwriteW,hilowriteW}
		);
endmodule

