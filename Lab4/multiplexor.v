module multiplexor #(parameter ANCHO=32,N=5)(
input [(2**N)*ANCHO-1:0] Entradas, //Las entradas se deben concatenar en una sola variable, {Entrada2^N-1,Entrada2^N-2,..,Entrada1,Entrada0}
input [N-1:0] SEL,
output reg [ANCHO-1:0] Salida
);
always @(*) begin
Salida=Entradas [ANCHO*SEL+:ANCHO];
end

endmodule