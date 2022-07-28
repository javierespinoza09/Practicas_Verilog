module Intr_handler_tb;
reg [31:0]Intruction;
reg fetch, imm_extend_WE, clk, rst;
reg [2:0] imm_SEL;
wire [4:0] RS1,RS2,RD;
wire [31:0] imm_out;
wire [6:0] OPC, func7;
wire [2:0] func3;

Instruction_handler A (.clk(clk),.rst(rst), .fetch(fetch), .imm_extend_WE(imm_extend_WE),
                     .imm_SEL(imm_SEL), 
                     .in_instruction(Intruction),
                     .RS1(RS1),.RS2(RS2),.RD(RD),
                     .imm_out(imm_out),
                     .OPC(OPC), .func7(func7), 
                     .func3(func3));
initial begin
Intruction=32'h00800def;
fetch=0;
clk=0;
rst=1;
imm_extend_WE=0;
imm_SEL=4;
forever begin
#5
clk=~clk;
end
end
initial begin
#20
rst=0;
#5
fetch=1;
#15
imm_extend_WE=1;
imm_SEL=4;
end
endmodule