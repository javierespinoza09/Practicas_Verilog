module BloqueSwitches #(parameter ANCHO=32,dirinterno='h314)(
input [ANCHO-1:0] Entrada,
input WE,rst,clk,
output [ANCHO-1:0] Salida,
input [15:0] sw
);

reg [ANCHO-1:0] EntradaREG;


bitsReg32 #(.ANCHO(ANCHO))reg32sw(.Entrada(EntradaREG), .WE(WE|sw[15]),.rst(rst),.clk(clk),.Salida(Salida));

always @(*) begin
if (WE) begin /*WE_interno=1; */EntradaREG=Entrada; end
else if (sw[15]==1) begin /* WE_interno=1; */EntradaREG={27'b0,sw[4:0]}; end
else begin /*WE_interno=0;*/ EntradaREG=Entrada; end
end
endmodule
