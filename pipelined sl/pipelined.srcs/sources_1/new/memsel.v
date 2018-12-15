`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/14 12:02:06
// Design Name: 
// Module Name: memsel
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
`include "define.vh"

module memsel(
	input wire [31:0] addr,instr,mem_to_reg_indata,reg_to_mem_indata,
	output reg [31:0] mem_to_reg_outdata,reg_to_mem_outdata,
	output reg [3:0] memwritesel
    );
	always@(*)
	begin
		memwritesel <= 4'b0000;
		case (instr[31:26])
			//以下为L操作=============================================================================
			`OP_LW:	
			if(addr[1:0]==2'b00) 	mem_to_reg_outdata <= mem_to_reg_indata;
			else		mem_to_reg_outdata <= 32'b0;							//应该报错，下同
			`OP_LB:		
			case (addr[1:0])
				2'b00:	mem_to_reg_outdata <= {{24{mem_to_reg_indata[31]}},mem_to_reg_indata[31:24]};
				2'b01:	mem_to_reg_outdata <= {{24{mem_to_reg_indata[23]}},mem_to_reg_indata[23:16]};
				2'b10:	mem_to_reg_outdata <= {{24{mem_to_reg_indata[15]}},mem_to_reg_indata[15:8]};
				2'b11:	mem_to_reg_outdata <= {{24{mem_to_reg_indata[7]}},mem_to_reg_indata[7:0]};
			endcase
			`OP_LBU:
			case (addr[1:0])
				2'b00:	mem_to_reg_outdata <= {24'b0,mem_to_reg_indata[31:24]};
				2'b01:	mem_to_reg_outdata <= {24'b0,mem_to_reg_indata[23:16]};
				2'b10:	mem_to_reg_outdata <= {24'b0,mem_to_reg_indata[15:8]};
				2'b11:	mem_to_reg_outdata <= {24'b0,mem_to_reg_indata[7:0]};
			endcase	
			`OP_LH:
			case (addr[1:0])
				2'b00:	mem_to_reg_outdata <= {{16{mem_to_reg_indata[31]}},mem_to_reg_indata[31:16]};
				2'b10:	mem_to_reg_outdata <= {{16{mem_to_reg_indata[15]}},mem_to_reg_indata[15:0]};
				default:	mem_to_reg_outdata <= 32'b0;
			endcase			
			`OP_LHU:
			case (addr[1:0])
				2'b00:	mem_to_reg_outdata <= {16'b0,mem_to_reg_indata[31:16]};
				2'b10:	mem_to_reg_outdata <= {16'b0,mem_to_reg_indata[15:0]};
				default:	mem_to_reg_outdata <= 32'b0;
			endcase
			//以下为S操作=============================================================================
			`OP_SW:	
			begin
				memwritesel <= 4'b1111;
				if(addr[1:0]==2'b00) 	reg_to_mem_outdata <= reg_to_mem_indata;
				else		reg_to_mem_outdata <= 32'b0;							//应该报错，下同
			end
			`OP_SB:	

			case (addr[1:0])
				2'b00:	begin	memwritesel <= 4'b1000;		reg_to_mem_outdata <= {4{reg_to_mem_indata[7:0]}};	/*reg_to_mem_indata[31:24]*/end
				2'b01:	begin	memwritesel <= 4'b0100;		reg_to_mem_outdata <= {4{reg_to_mem_indata[7:0]}};	/*reg_to_mem_indata[23:16]*/end
				2'b10:	begin	memwritesel <= 4'b0010;		reg_to_mem_outdata <= {4{reg_to_mem_indata[7:0]}};	/*reg_to_mem_indata[15:8]*/	end
				2'b11:	begin	memwritesel <= 4'b0001;		reg_to_mem_outdata <= {4{reg_to_mem_indata[7:0]}};	/*reg_to_mem_indata[7:0]*/	end
				default:	reg_to_mem_outdata <= {4{2'haa}};
			endcase
			`OP_SH:
			case (addr[1:0])
				2'b00:	begin	memwritesel <= 4'b1100;		reg_to_mem_outdata <= {2{reg_to_mem_indata[15:0]}};		end
				2'b10:	begin	memwritesel <= 4'b0011;		reg_to_mem_outdata <= {2{reg_to_mem_indata[15:0]}};		end
				default:	reg_to_mem_outdata <= 32'b0;
			endcase			
			default : begin		mem_to_reg_outdata <=32'b0;		reg_to_mem_outdata <=32'b0;		end
		endcase
	end
endmodule
