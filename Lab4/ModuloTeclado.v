

module ModuloTeclado(
    input CLK, A, B, C, D, E, WE_Procesador, RESET,
    input [31:0] ProcesadorIN_Mux,
    output [31:0] OUT

);
 
wire Gen_PulsoOUT;
wire [3:0] SalidaDeco;
wire [31:0] SalidaDecoCompleta, SalidaMux;


GPulso G0 (
		.clk(CLK),.rst(rst),
		.in(E),
	    .out(Gen_PulsoOUT));

Teclado_Deco F2(
    .a(A), .b(B), .c(C), .d(D),
    .Salida(SalidaDeco)    
    );

CompletarTecladoOUT F3(
    .IN(SalidaDeco),
    .OUT(SalidaDecoCompleta)
);  
MuxTeclado F4(
    .SEL(WE_Procesador),
    .Teclado_DecoOUT(SalidaDecoCompleta), .Procesador(ProcesadorIN_Mux),
    .SalidaMux(SalidaMux)
);
RegistroTeclado F5(
    .WE_Procesador(WE_Procesador), .WE_Teclado(Gen_PulsoOUT), .CLK(CLK),
    .IN(SalidaMux), .RESET(RESET),
    .OUT(OUT)
);
    
endmodule 