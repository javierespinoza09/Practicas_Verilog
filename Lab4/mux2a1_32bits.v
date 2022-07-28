module mux2a1_32bits #(parameter ANCHO=32)(
input [ANCHO-1:0] Entrada0, Entrada1,
input SEL,
output reg [ANCHO-1:0] Salida 
);

always @(*) begin
case (SEL)
    0: Salida=Entrada0;
    1: Salida=Entrada1;
    default: Salida=Entrada0;
endcase
end

endmodule
