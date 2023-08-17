module dff_arst (
		input D, rst, clk,
		output reg Q
		);
always@(posedge clk, negedge rst) begin
	if(!rst) Q <= 1'b0;
	else Q <= D;
end
endmodule
