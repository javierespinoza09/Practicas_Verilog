module ALU #(parameter ANCHO=32)(
input [ANCHO-1:0] A,B,
input [3:0] SELOP,
output reg [ANCHO-1:0] Resultado,
output reg flagC,flagZ,flagError,flagNegativo
);

always @(*) begin

case(SELOP)
4'b0000:Resultado=A+B; //Suma
4'b1000:Resultado=A-B;  //Resta
4'b0111:Resultado=A&B;  //AND
4'b0110:Resultado=A|B;  //OR 
4'b0100:Resultado=A^B;  //XOR 
4'b0001:Resultado=A<<B;  //sll
4'b0101:Resultado=A>>B;  //srl
4'b1101:Resultado=A>>>B[4:0];  //sra
4'b0010: Resultado=(A < B) ? 1 : 0;  //sltu
//4'b0011:Resultado=(A < B) ? 1 : 0;
default: begin Resultado=0; flagError=1; end

endcase
flagNegativo=Resultado[31];

if (Resultado==0) flagZ=1;
else flagZ=0;
if ((A+B)>(2**ANCHO-1)) flagC=1;
else flagC=0;
end

endmodule