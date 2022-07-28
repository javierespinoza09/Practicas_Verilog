`timescale 1ns/1ps
module Bloque_Timer_tb();

reg clk,rst,WE;
reg [31:0] Entrada;
wire [31:0] Salida;

BloqueTimer BT(rst,clk,WE,Entrada, Salida);


initial begin
clk=0;
rst=1;
Entrada=0;
WE=0;
forever begin
#50
clk=~clk;

end

end

initial begin 
#30
rst=0;
#10
Entrada=20;
#20
WE=1;
#200
WE=0;

#9000
$finish;

end




endmodule