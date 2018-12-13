`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/13 20:03:28
// Design Name: 
// Module Name: jalsel
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


module jalsel(
	input [4:0] writereg_in,
	input jal,bal,
	output reg [4:0] writereg_out
    );
always @(*) 
begin
	if(jal) 
	begin
		if(writereg_in==5'b0)
		begin
			writereg_out<=31;
		end
		else
		begin
			writereg_out<=writereg_in;
		end
	end 
	else if(bal)
	begin
		writereg_out<=31;
	end
	else 
	begin
		 writereg_out<=writereg_in;
	end

end
endmodule
