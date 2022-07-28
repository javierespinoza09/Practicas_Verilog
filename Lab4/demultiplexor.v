module demultiplexor #(parameter ANCHO=8+1,N=2)(

input [ANCHO-1:0] Entrada,
input [N-1:0] SEL,
output reg [(2**N)*ANCHO-1:0] Salidas  //Las salidas se concatenan en una sola variable {Salida2^N-1,Salida2^N-2,...,Salida1,Salida0}

);


integer i;
always @(*) begin

    for (i=0;i<2**N;i=i+1) begin
        Salidas [ANCHO*i +:ANCHO]=0;
        if (SEL==i&SEL!=0)  Salidas [ANCHO*i+:ANCHO]=Entrada;
        
    end
        
end



endmodule