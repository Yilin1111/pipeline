`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 17:18:00
// Design Name: 
// Module Name: hazard
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


module hazard(
	//fetch stage
	output stallF,
	//decode stage
	input [4:0] rsD,rtD,
	input branchD,jrD,
	output forwardaD,forwardbD,stallD,
	//execute stage
	input [4:0] rsE,rtE,writeregE,
	input regwriteE,memtoregE,div_startE,div_readyE,
	output [1:0] forwardaE,forwardbE,
	output flushE,stallE,
	//mem stage
	input [4:0] writeregM,
	input regwriteM,memtoregM,
	//write back stage
	input [4:0] writeregW,
	input regwriteW
    );
	wire lwstall,branchstall,stall_divE,jrstall;
	assign stall_divE = div_startE & ~div_readyE;
	assign forwardaE =  (rsE && rsE==writeregM && regwriteM) ? 2'b10 :
					   	(rsE && rsE==writeregW && regwriteW) ? 2'b01 : 2'b00 ;
	assign forwardbE = 	(rtE && rtE==writeregM && regwriteM) ? 2'b10 :
					   	(rtE && rtE==writeregW && regwriteW) ? 2'b01 : 2'b00 ;
	assign forwardaD = rsD && rsD==writeregM && regwriteM;
	assign forwardbD = rtD && rtD==writeregM && regwriteM;
	assign lwstall = (rsD==rtE || rtD==rtE) && memtoregE;
	assign branchstall = branchD && regwriteE && (writeregE==rsD || writeregE==rtD);
	assign jrstall = jrD && regwriteE && (writeregE==rsD);
	assign stallD = lwstall | branchstall | stall_divE | jrstall;
	assign stallF = lwstall | branchstall | stall_divE | jrstall;
	assign flushE = lwstall | branchstall | jrstall;
	assign stallE = stall_divE;
endmodule
