module bitsReg32 #(parameter ANCHO=32)(
    input [ANCHO-1:0] Entrada,
    input WE,rst,clk,
    output reg [ANCHO-1:0] Salida
);
always @(posedge clk) begin
if (rst) Salida=0;
else if (WE) Salida=Entrada;
end
endmodule