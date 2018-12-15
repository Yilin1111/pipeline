`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/25 16:19:03
// Design Name: 
// Module Name: eqcmp
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


module eqcmp(
	input wire [31:0] a,b,
	input wire [5:0] op,
	input wire [4:0] rt,
	output reg y
    );
	always@(*)
	begin
		case(op)
			`OP_BEQ:	y <= (a == b) ? 1 : 0;
			`OP_BNE:	y <= (a == b) ? 0 : 1;
			`OP_BGTZ:	y <= ($signed(a) > 0)  ? 1 : 0;
			`OP_BLEZ:	y <= ($signed(a) <= 0) ? 1 : 0;
			`OP_BLTZ:	
			case(rt)
				`RT_BLTZ:		y <= ($signed(a) < 0)  ? 1 : 0;
				`RT_BGEZ:		y <= ($signed(a) >= 0) ? 1 : 0;
				`RT_BLTZAL:		y <= ($signed(a) < 0)  ? 1 : 0;	//
				`RT_BGEZAL:		y <= ($signed(a) >= 0) ? 1 : 0;	//
				default:		y <= 0;					//错误指令
			endcase
			default:	y <= 0;							//错误指令
		endcase
	end
endmodule
