// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
`timescale 1ns/10ps
module muxdff_tb;
  reg reset_tb, push_tb, pop_tb,clk_tb;
  reg [3:0] D_in_tb;
wire [3:0] pc_tb;
  wire [3:0] D_out_tb [7:0];
  wire [3:0] Data_out_tb;
  wire push_out_tb;
  

control DUT0 (
  .reset(reset_tb), .push(push_tb), .pop(pop_tb), .clk(clk_tb),
  .push_out(push_tb_out), .pc(pc_tb));

  
reg_dff DUT1 (
  .reset(reset_tb), .push(push_tb_out), .D_in(D_in_tb),
  .D_out(D_out_tb)
);
  
  
salida DUT2(
  .Data_in(D_out_tb), .pc(pc_tb),
  .Data_out(Data_out_tb)
  );
  
  
  
initial begin
$dumpfile("test_dff_arst.vcd");
  $dumpvars(0,muxdff_tb);
end

initial begin
  clk_tb = 0;
  reset_tb = 1;
  push_tb = 0;
  D_in_tb = 0;
  pop_tb = 0;
  #10
  reset_tb = 0;
end 

initial begin
  
  for(int i = 0;i<50;i++)begin
    #5
    clk_tb <= ~clk_tb;      
  end 
end
  
  
initial begin
  for(int i = 0;i<5;i++)begin
    #5
    D_in_tb=i;
    #12
    push_tb = 1;
    #7
    push_tb = 0;
      
  end 
end
  


endmodule