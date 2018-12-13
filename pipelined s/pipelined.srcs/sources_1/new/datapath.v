`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:19:03
// Design Name: 
// Module Name: datapath
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


module datapath(
	input wire clk,rst,
	//fetch stage
	output wire[31:0] pcF,
	input wire[31:0] instrF,
	//decode stage
	input wire pcsrcD,branchD,
	input wire jumpD,jrD,
	output wire equalD,
	output wire[31:0] instrD,
	//execute stage
	input wire memtoregE,
	input wire alusrcE,regdstE,
	input wire regwriteE,hilowriteE,hiloselE,ifhiloE,jalE,balE,
	input wire[4:0] alucontrolE,
	output wire flushE,stallE,overflowE,
	//mem stage
	input wire memtoregM,
	input wire regwriteM,
	output wire[31:0] aluoutM,writedataM,
	input wire[31:0] readdataM,
	//writeback stage
	input wire memtoregW,regwriteW
    );
	
	// assign opD = instrD[31:26];
	// assign functD = instrD[5:0];
	// assign rsD = instrD[25:21];
	// assign rtD = instrD[20:16];
	// assign rdD = instrD[15:11];
	// assign shamtD = instrD[10:6];
	//fetch stage
	wire stallF;
	//FD
	wire [31:0] pcnextFD,pcnextbrFD,pcnextjrFD,pcplus4F,pcbranchD;
	//decode stage
	wire [31:0] pcplus4D;
	wire forwardaD,forwardbD;
	wire [4:0] rsD,rtD,rdD,shamtD;
	wire flushD,stallD; 
	wire [31:0] signimmD,signimmshD;
	wire [31:0] srcaD,srca2D,srcbD,srcb2D;
	wire [5:0] opD,functD;
	//execute stage
	wire [1:0] forwardaE,forwardbE;
	wire [4:0] rsE,rtE,rdE,shamtE;
	wire [4:0] writeregE;
	wire [4:0] writereg1E;
	wire [31:0] pcplus4E,pcplus8E;
	wire [31:0] signimmE;
	wire [31:0] srcaE,srca2E,srcbE,srcb2E,srcb3E,srcb4E;
	wire [31:0] aluoutE,aluout1E,hi_inE,lo_inE,hi_alu_inE,lo_alu_inE,hi_div_inE,lo_div_inE,hi_outE,lo_outE,hilo_out;
	//hilo_out是从hi_outE,lo_outE选择出来的输出
	wire div_start,div_signed,div_annul,div_ready;

	//mem stage
	wire [4:0] writeregM;
	//writeback stage
	wire [4:0] writeregW;
	wire [31:0] aluoutW,readdataW,resultW;

	//hazard detection
	hazard h(
		//fetch stage
		stallF,
		//decode stage
		rsD,rtD,
		branchD,jrD,
		forwardaD,forwardbD,
		stallD,
		//execute stage
		rsE,rtE,
		writeregE,
		regwriteE,
		memtoregE,
		div_start,
		div_ready,
		forwardaE,forwardbE,
		flushE,stallE,
		//mem stage
		writeregM,
		regwriteM,
		memtoregM,
		//write back stage
		writeregW,
		regwriteW
		);

	//next PC logic (operates in fetch an decode)
	mux2 #(32) pcbrmux(pcplus4F,pcbranchD,pcsrcD,pcnextbrFD);
	mux2 #(32) jrmux({pcplus4D[31:28],instrD[25:0],2'b00},srca2D,jrD,pcnextjrFD);
	mux2 #(32) pcmux(pcnextbrFD,pcnextjrFD,jumpD,pcnextFD);

	//regfile (operates in decode and writeback)
	regfile rf(clk,regwriteW,rsD,rtD,writeregW,resultW,srcaD,srcbD);

	//fetch stage logic
	flopenr #(32) pcflopF(clk,rst,~stallF,pcnextFD,pcF);
	adder pcadd1(pcF,32'b100,pcplus4F);
	//decode stage
	flopenr #(32) r1D(clk,rst,~stallD,pcplus4F,pcplus4D);
	flopenrc #(32) r2D(clk,rst,~stallD,flushD,instrF,instrD);
	signext se(instrD[15:0],opD,signimmD);
	sl2 immsh(signimmD,signimmshD);
	adder pcadd2(pcplus4D,signimmshD,pcbranchD);
	mux2 #(32) forwardamux(srcaD,aluoutM,forwardaD,srca2D);
	mux2 #(32) forwardbmux(srcbD,aluoutM,forwardbD,srcb2D);
	eqcmp comp(srca2D,srcb2D,opD,rtD,equalD);

	assign opD = instrD[31:26];
	assign functD = instrD[5:0];
	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];
	assign shamtD = instrD[10:6];

	//execute stage
	flopenr #(32) 	pcflopE(clk,rst,~stallF,pcplus4D,pcplus4E);
	flopenrc #(32) 	r1E(clk,rst,~stallE,flushE,srcaD,srcaE);
	flopenrc #(32) 	r2E(clk,rst,~stallE,flushE,srcbD,srcbE);
	flopenrc #(32) 	r3E(clk,rst,~stallE,flushE,signimmD,signimmE);
	flopenrc #(5) 	r4E(clk,rst,~stallE,flushE,rsD,rsE);
	flopenrc #(5) 	r5E(clk,rst,~stallE,flushE,rtD,rtE);
	flopenrc #(5) 	r6E(clk,rst,~stallE,flushE,rdD,rdE);
	flopenrc #(5) 	r7E(clk,rst,~stallE,flushE,shamtD,shamtE); 

	adder pcadd3(pcplus4E,32'b100,pcplus8E);
	mux3 #(32) forwardaemux(srcaE,resultW,aluoutM,forwardaE,srca2E);
	mux3 #(32) forwardbemux(srcbE,resultW,aluoutM,forwardbE,srcb2E);
	mux2 #(32) srcbmux(srcb2E,signimmE,alusrcE,srcb3E);
	mux2 #(32) ifhilomux(srcb3E,hilo_out,ifhiloE,srcb4E);

	alu alu(srca2E,srcb4E,alucontrolE,shamtE,aluout1E,hi_alu_inE,lo_alu_inE,overflowE);
	divdec divdec(alucontrolE,div_ready,div_start,div_signed,div_annul);
	div div(clk,rst,div_signed,srca2E,srcb4E,div_start,div_annul,{hi_div_inE,lo_div_inE},div_ready);
	mux2 #(5) wrmux(rtE,rdE,regdstE,writereg1E);
	mux2 #(64) hilo_inmux({hi_alu_inE,lo_alu_inE},{hi_div_inE,lo_div_inE},div_start|div_ready,{hi_inE,lo_inE});
	hilo_reg hilo(clk,rst,hilowriteE,hi_inE,lo_inE,hi_outE,lo_outE);
	mux2 #(32) hiloselmux(lo_outE,hi_outE,hiloselE,hilo_out);
	jalsel jalsel(writereg1E,jalE,balE,writeregE);
	mux2 #(32) jaldatamux(aluout1E,pcplus8E,jalE|balE,aluoutE);
	//mem stage
	flopr #(32) r1M(clk,rst,srcb2E,writedataM);
	flopr #(32) r2M(clk,rst,aluoutE,aluoutM);
	flopr #(5) r3M(clk,rst,writeregE,writeregM);

	//writeback stage
	flopr #(32) r1W(clk,rst,aluoutM,aluoutW);
	flopr #(32) r2W(clk,rst,readdataM,readdataW);
	flopr #(5) r3W(clk,rst,writeregM,writeregW);
	mux2 #(32) resmux(aluoutW,readdataW,memtoregW,resultW);
	
endmodule
