module PC_tb;
reg clk, rst;
reg [1:0] SEL;
reg [31:0] jump_dir;
wire [31:0] PC_out;
wire [31:0] PC_inc;

PC A (.clk(clk), .rst(rst),
    .SEL(SEL),
    .jump_dir(jump_dir),
    .PC_out(PC_out),
    .PC_inc(PC_inc));
initial begin
clk=0;
rst=1;
SEL=2;
jump_dir=4;

forever begin
#5
clk=~clk;
end
end
initial begin
#10
rst=0;
#40
SEL=1;
jump_dir=4;

#15
SEL=2;
end

endmodule 