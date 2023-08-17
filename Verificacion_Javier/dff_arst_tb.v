`timescale 1ns/10ps
module dff_arst_tb;
reg D_in, rst_in,clk_in;
wire Q_out;
dff_arst DUT1 (
		.D(D_in), .rst(rst_in), .clk(clk_in),
		.Q(Q_out)
);
initial begin
$dumpfile("test_dff_arst.vcd");
$dumpvars(0,dff_arst_tb);
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
