`timescale 1ns/10ps
module ser_reg_tb;
parameter Depth = 4;
reg D_in, rst_in,clk_in;
wire [Depth-1:0] D_out;
ser_reg #(.Depth(Depth)) DUT1 (
	.rst(rst_in), .D_in(D_in), .clk(clk_in),
	.D_out(D_out));
initial begin
$dumpfile("test_ser_reg.vcd");
$dumpvars(0,ser_reg_tb);
end

initial begin
forever begin
	#10
	clk_in = ~clk_in;
end
end

initial begin
D_in = 0;
clk_in = 1;
rst_in = 0;
#100
rst_in = 1;
#55
D_in = 1;
#12
rst_in = 0;
#23
rst_in = 1;
#50
D_in = 0;


$finish;
end
endmodule
