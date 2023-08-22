// Code your testbench here
// or browse Examples
`timescale 1ns/10ps
module muxdff_tb;
  reg reset_tb, push_tb, pop_tb,clk_tb;
  reg [3:0] D_in_tb;
wire [3:0] pc_tb;
  wire [3:0] D_out_tb [7:0];
  wire [3:0] Data_out_tb, push_out_tb;
  

control DUT0 (
  .reset(reset_tb), .push(push_tb), .pop(pop_tb), .clk(clk_tb),
  .push_out(push_tb_out), .pc(pc_tb));

  
serial_reg DUT1 (
  .reset(reset_tb), .push(push_tb_out), .D_in(D_in_tb),
  .D_out(D_out_tb)
);
  
  
param_mux DUT2(
  .Data_in(D_out_tb), .pc(pc_tb),
  .Data_out(Data_out_tb)
  );
  
  
  
initial begin
$dumpfile("test_dff_arst.vcd");
  $dumpvars(0,muxdff_tb);
end

initial begin
forever begin
	#5
  	clk_tb = ~clk_tb;
	push_tb = ~push_tb;
end
end
  
initial begin
clk_tb = 1;
reset_tb = 0;
push_tb = 1;
D_in_tb = 0;
  pop_tb = 0;


#15
reset_tb = 1;
#15
reset_tb = 0;
#15
D_in_tb = 1;
#15
D_in_tb = 2;
#15
D_in_tb = 3;
#15
D_in_tb = 4;

#15
D_in_tb = 5;

#15
D_in_tb = 6;
pop_tb = 1;
#15
D_in_tb = 7;
pop_tb = 0;
#15
D_in_tb = 8;
#15
D_in_tb = 9;
#50


#150


$finish;
end
endmodule
