`timescale 1ns/1ps
module Micro_ROM_RAM_tb;
reg clk;
reg rst,A,B,C,D,E;
/*wire [31:0]direccion;
wire [31:0] Imm;
wire [31:0] Read_Data_o;
wire [31:0] Instr;
wire [8:0] P_Addrs;*/
wire [7:0] Anode_Control;
wire [6:0] Cathode_Control;
Micro_ROM_RAM U0 (.clk(clk), .rst(rst),
                  .JB({D,C,B,A,E}),
                  .Anode_Control(Anode_Control),
                  .Cathode_Control(Cathode_Control));
initial begin
clk=0;
rst=1;
#2500
rst=0;
A=1;
B=1;
C=1;
D=1;
E=0;
#200
E=1;
end
initial begin 
forever begin
    #5 clk=~clk;
end
#10000
$finish;
end

endmodule