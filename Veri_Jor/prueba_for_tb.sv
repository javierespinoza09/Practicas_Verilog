`timescale 1ns/10ps
module f_tb;
  reg [3:0] a_tb;
  wire [3:0] b_tb;
  
  f DUT0 (.a(a_tb),.b(b_tb));
  
  initial begin
    for(int i = 0;i<5;i++)begin
      #5
      a_tb=i;
      
    end
end

  initial begin
$dumpfile("test_dff_arst.vcd");
  $dumpvars(0,f_tb);
end
  
endmodule 