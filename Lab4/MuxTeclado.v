module MuxTeclado(
    input SEL,
    input [31:0] Teclado_DecoOUT, Procesador,
    output reg [31:0] SalidaMux
);
always @(*)begin
    case(SEL)
    1'b0: SalidaMux = Teclado_DecoOUT;
    1'b1: SalidaMux = Procesador;
    endcase
end

endmodule