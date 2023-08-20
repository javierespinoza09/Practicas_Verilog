`timescale 1ns/10ps
module muxdff_tb;
reg reset_tb, push_tb,D_in_tb;
reg [3:0] pc_tb;
wire [7:0] D_out_tb;
wire Data_out_tb;
  
  
mux_dff DUT1 (
  .reset(reset_tb), .push(push_tb), .D_in(D_in_tb),
  .D_out(D_out_tb)
);
  
  
salida DUT2(
  .Data_in(D_out_tb), .pc(pc_tb), .clk(push_tb),
  .Data_out(Data_out_tb)
  );
  
  
  
initial begin
$dumpfile("test_dff_arst.vcd");
  $dumpvars(0,muxdff_tb);
end

initial begin
forever begin
	#5
	push_tb = ~push_tb;
end
end
  
initial begin
reset_tb = 0;
push_tb = 1;
D_in_tb = 0;
pc_tb = 0;

#15
reset_tb = 1;
pc_tb = 1;

#15
D_in_tb = 1;
#15
pc_tb = 6;
#45
D_in_tb = 0;
#30
reset_tb = 0;
#15
reset_tb = 1;
#90


$finish;
end
endmodule