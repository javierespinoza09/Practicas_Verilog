module Mux4_1(
input [3:0] i_Teclado, i_Procesador,
input i_SEL,
output o_RegTeclado
);

always @(*)begin
    case(i_SEL)
        0: o_RegTeclado = i_Teclado;
        1: o_RegTeclado = i_Procesador;
    endcase
end

endmodule