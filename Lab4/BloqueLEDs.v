module BloqueLEDs #(parameter ANCHO=32,dirinterno='h310)(
 input [ANCHO-1:0] Entrada, 
 input WE,rst,clk,
 output reg [ANCHO-1:0]  Salida,
 output reg [15:0] led
 
);
//reg WE_interno;
wire [31:0]SalidaREG;
always @(*) begin
Salida=SalidaREG;
led=SalidaREG[15:0];
end

bitsReg32 #(.ANCHO(ANCHO))reg32led(.Entrada(Entrada), .WE(WE),.rst(rst),.clk(clk),.Salida(SalidaREG));
/*
always @(*) begin
if (WE_interno&&Dir==dirinterno)WE_interno=1;
else WE_interno=0;
led=Salida[15:0];
end
*/
endmodule