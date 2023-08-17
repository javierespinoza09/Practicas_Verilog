module ser_reg #(parameter Depth = 4) (
	input rst, D_in, clk,
	output [Depth-1:0] D_out)
;
wire [Depth-1:0] d;
wire [Depth-1:0] q;
genvar i;
generate
	for (i=0;i<Depth;i=i+1) 
		begin
			dff_arst u0 (.D(d[i]), .rst(rst), .clk(clk),.Q(q[i]));
		end
endgenerate
assign d[0] = D_in;
assign d[Depth-1:1] = q[Depth-2:0];
assign D_out = q;

endmodule
