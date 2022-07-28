module Bloque7Segmentos #(parameter ANCHO=32,dirinterno='h30C)(
input [ANCHO-1:0] Entrada, Dir,
input WE,rst,clk,
output [ANCHO-1:0] Salida,
output [7:0]Anode_Control,
output [6:0]Cathode_Control
);

//reg WE_interno;

Display #(.ANCHO(ANCHO))D1(.Dis0(Salida[3:0]),.Dis1(Salida[7:4]),.Dis2(Salida[11:8]),.Dis3(Salida[15:12]),
.Dis4(Salida[19:16]),.Dis5(Salida[23:20]),.Dis6(Salida[27:24]),.Dis7(Salida[31:28]),.clk(clk), .rst(rst),
.Anode_Control(Anode_Control),.Cathode_Control(Cathode_Control));

bitsReg32 #(.ANCHO(ANCHO))reg327Seg(.Entrada(Entrada), .WE(WE),.rst(rst),.clk(clk),.Salida(Salida));

/*
always @(*) begin
if (WE_interno&&Dir==dirinterno)WE_interno=1;
else WE_interno=0;
end
*/
endmodule