`timescale 1ns / 1ps

module TB_ModuloTeclado();

reg CLK10MHz, A, B, C, D, E, SEL;
wire [31:0] ProcesadorIN_Mux;
wire [31:0] Salida;
wire Gen_Pulso;
wire [3:0] SalidaDeco2;
wire [31:0] SalidaDecoCompleta2;
wire [31:0] SalidaMux2;


assign ProcesadorIN_Mux = 32'b0;

ModuloTeclado F1(
    .CLK(CLK10MHz), .A(A), .B(B), .C(C), .D(D), .E(E), 
    .WE_Procesador(SEL), .RESET(0),
    .ProcesadorIN_Mux(ProcesadorIN_Mux),
    .OUT(Salida),
    .Gen_Pulso2(Gen_Pulso),
    .SalidaDeco2(SalidaDeco2),
    .SalidaDecoCompleta2(SalidaDecoCompleta2),
    .SalidaMux2(SalidaMux2)
);

//10 MHz
initial begin 
    CLK10MHz = 0;
    forever #50 CLK10MHz = ~CLK10MHz;
end

initial begin
    E=1;
    A=0;
    B=0;
    C=0;
    D=0;
    SEL=0;
    #2000000 $finish;
end

endmodule 