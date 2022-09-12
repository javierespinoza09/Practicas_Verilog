`timescale 1ns / 1ps

module SimulationRegister2();

reg CLK;
reg EN;
reg Reset;
reg [31:0] ADC;
reg [31:0] Generador;

wire Flag;
wire New;
wire [11:0] Umbral, ComparadorDatos;

RegistroControl2 F1(
    .CLK(CLK), .EN(EN), .RESET(Reset),
    .GENERADOR_DATOS(Generador), .REGISTRO_DATOS(ADC), .FLAG(Flag), .NEW(New),
    .COMPARADOR_DATOS(ComparadorDatos), .UMBRAL(Umbral)
    );

initial begin
    CLK = 0;
    forever #10 CLK = ~CLK;
end

initial begin
    EN =1;
    Reset = 0;
    ADC = 32'b0;
    Generador = 32'b0;
    
    #10 
    ADC = $random;
    Generador = $random;
    
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    #10           
    ADC = $random;
    
    
end


endmodule
