module banco_reg #(parameter ANCHO=32,N=5)(

input [N-1:0] addr_rs1,addr_rs2,addr_rd,
input [ANCHO-1:0] data_in,
input clk,rst,we,

output [ANCHO-1:0] rs1,rs2

);

wire [(2**N)*(ANCHO+1)-1:0] SalidasDEMUX;
wire [(2**N)*ANCHO-1:0] EntradasMUX;

demultiplexor #(.ANCHO(ANCHO+1),.N(N))D1(.Entrada({we,data_in}),.SEL(addr_rd),.Salidas(SalidasDEMUX));

generate
genvar i;

    for (i=0;i<2**N;i=i+1) begin

        regPL #(.ANCHO(ANCHO))RN(
        .Entrada(SalidasDEMUX[i*(ANCHO+1)+:ANCHO]),
        .clk(clk),.rst(rst),.EN(SalidasDEMUX[i*(ANCHO+1)+ANCHO]),
        .Salida(EntradasMUX[i*ANCHO+:ANCHO]));
        

end

endgenerate

multiplexor #(.ANCHO(ANCHO),.N(N))M1(.Entradas(EntradasMUX),.SEL(addr_rs1),.Salida(rs1));
multiplexor #(.ANCHO(ANCHO),.N(N))M2(.Entradas(EntradasMUX),.SEL(addr_rs2),.Salida(rs2));

endmodule