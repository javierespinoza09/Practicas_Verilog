module demux1a2_32bits #(parameter ANCHO=32)(
input [ANCHO-1:0] Entrada,
input SEL,
output reg [ANCHO-1:0] Salida0, Salida1 
);

always @(*) begin
case (SEL)
    0: begin
    Salida0=Entrada;
    Salida1=0;
    end
    1: begin
    Salida1=Entrada;
    Salida0=0;
    end
    default: Salida1=Entrada;
endcase
end

endmodule