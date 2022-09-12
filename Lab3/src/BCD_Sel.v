module BCD_Sel #(parameter ANCHO=4 )(input [ANCHO-1:0] SW7,SW6,SW5,SW4,SW3,SW2,SW1,SW0, input [2:0] SEL, output reg [ANCHO-1:0] Salida );
always @(*) begin
        case(SEL)
            0: Salida=SW7;
            1: Salida=SW6;
            2: Salida=SW5;
            3: Salida=SW4;
            4: Salida=SW3;
            5: Salida=SW2;
            6: Salida=SW1;
            7: Salida=SW0;
            default: Salida = 0;
        endcase
    end
endmodule