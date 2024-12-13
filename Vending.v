`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    18:32:31 12/13/24
// Design Name:    
// Module Name:    Vending
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module Vending(p_out, c_out,clk,rst,c5,c10);
input clk,rst,c5,c10; // c5 is 5 units and c10 is 10 units.
output reg p_out, c_out; //Product out and Change out.
// state declaration
reg[1:0] current, next;

parameter s0 = 2'b00;
parameter s5 = 2'b01;
parameter s10 = 2'b10;
parameter s15 = 2'b11;

always @(posedge clk) begin
	if (rst) 
		current <= s0;
	else 
		current <= next;
end

always @(posedge clk) begin 
	p_out = 0;
	c_out = 0;
	next = current;
	
	case(current)
		s0: begin
			if (c5)
				next = s5;
			else if (c10)
				next = s10;
			end
		
		s5: begin 
			if (c5)
				next = s10;
			else if (c10) begin
				next = s15;
				p_out = 1;
				end
			end

		s10: begin 
			if (c5) begin
				next = s15;
				p_out = 1;
				end
			else if (c10) begin
				next = s15;
				p_out = 1;
				c_out = 1;
				end
			end 

			s15: begin 
				next = s0;
			end
		endcase 
	 end
endmodule
