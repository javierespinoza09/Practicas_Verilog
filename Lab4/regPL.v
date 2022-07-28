module regPL #(parameter ANCHO=8)(
input [ANCHO-1:0] Entrada,
input EN,clk,rst,
output reg [ANCHO-1:0] Salida

);


always @(posedge clk) begin
    if (rst==1) Salida <=0;
    else if (EN==1) begin
        Salida<=Entrada;
    end

end

endmodule