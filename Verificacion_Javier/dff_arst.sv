module dff_arst (
		input D, rst, clk,
		output reg Q
		);
always@(posedge clk, posedge rst) begin
	if(rst) Q <= 0;
	else Q <= D;
end
endmodule
