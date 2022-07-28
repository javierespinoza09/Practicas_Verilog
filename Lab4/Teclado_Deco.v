module Teclado_Deco(
    input a, b, c, d,
    output reg [3:0] Salida    
    );
    
    always @(*)begin
        case({a,b,c,d})
            //OPERANDOS
            4'b1000: Salida = 4'b0000; //Numero 0
            4'b0011: Salida = 4'b0001; //NUMERO 1
            4'b1011: Salida = 4'b0010; //Numero 2
            4'b0111: Salida = 4'b0011; //Numero 3
            4'b0001: Salida = 4'b0100; //Numero 4
            4'b1001: Salida = 4'b0101; //Numero 5
            4'b0101: Salida = 4'b0110; //Numero 6
            4'b0010: Salida = 4'b0111; //Numero 7
            4'b1010: Salida = 4'b1000; //Numero 8
            4'b0110: Salida = 4'b1001; //Numero 9
            
            //OPERADORES
            4'b0000: Salida = 4'b1111; //Tecla *
            4'b0100: Salida = 4'b1110; //Tecla #
            4'b1111: Salida = 4'b1101; //Tecla A
            4'b1101: Salida = 4'b1100; //Tecla B
            4'b1110: Salida = 4'b1011; //Tecla C
            4'b1100: Salida = 4'b1010; //Tecla D
            
        endcase     
    end
    
endmodule