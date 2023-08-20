// Code your testbench here
// or browse Examples
`timescale 1ns/10ps
module control_tb;
reg reset_tb, push_tb,pop_tb,clk_tb;
  wire [3:0] pc_tb;
control DUT1 (
  .reset(reset_tb), .push(push_tb), .pop(pop_tb),.clk(clk_tb),
  .pc(pc_tb)
);
initial begin
$dumpfile("test_dff_arst.vcd");
  $dumpvars(0,control_tb);
end

initial begin
forever begin
	#5
	clk_tb = ~clk_tb;
end
end

initial begin
reset_tb = 0;
push_tb = 0;
pop_tb = 0;
clk_tb = 1;


#50
reset_tb = 1;
#15
reset_tb = 0;
#15
push_tb = 1;
#15
push_tb = 0;
#15
push_tb = 1;
#15
push_tb = 0;
#15
pop_tb = 1;
#15
pop_tb = 0;
#15
pop_tb = 1;
#15
pop_tb = 0;
#15
pop_tb = 1;
push_tb = 1;
reset_tb =1;
#15
pop_tb = 0;
push_tb = 0;
reset_tb = 0;
#15
pop_tb = 1;
push_tb = 1;
#15
pop_tb = 0;
push_tb = 0;
#50




$finish;
end
endmodule