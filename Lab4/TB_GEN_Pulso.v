`timescale 1ns / 1ps

module TB_Pulsador;

reg CLK100MHz, CLK10MHz, Reset, Pulsador;
wire Salida;

wire CLK2, CLK3;


Gen_Pulso F1(.KEY(Pulsador), .CLK(CLK10MHz), .RESET(Reset),
.SALIDA(Salida), .CLK3(CLK2), .CLK4(CLK3));

//100 MHz
initial begin 
    CLK100MHz = 0;
    forever #5 CLK100MHz = ~CLK100MHz;
end

//10 MHz
initial begin 
    CLK10MHz = 0;
    forever #50 CLK10MHz = ~CLK10MHz;
end

initial begin
    Reset = 0;
    Pulsador = 0;
    #10;
    #1000
    Pulsador =1;
    #1000
    Pulsador =0;
    #2000000;
    Pulsador =1;
    #2000000;
    Pulsador =0;
    #2000000;
    Pulsador =0;
    #2000000;
    #10 $finish;
    

end


endmodule