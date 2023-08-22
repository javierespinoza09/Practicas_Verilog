`timescale 1ns/10ps
module dff_arst #(parameter bits = 4) (
input [bits-1:0] D, 
input rst, clk,
output reg [bits-1:0] Q);
	always@(posedge clk, posedge rst) begin
		if(rst) Q <= 0;
		else Q <= D;	
	end
endmodule
