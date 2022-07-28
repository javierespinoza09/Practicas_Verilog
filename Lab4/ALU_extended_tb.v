`timescale 1ns/1ps
module ALU_extended_tb;
reg [31:0] RS1_data, RS2_data,imm,PC;
reg srcB_SEL, srcA_SEL;
reg [3:0]SEL_OP;
wire [31:0] Resultado;
wire flagC,flagZ,flagError,flagNegativo;
extended_ALU A (RS1_data, RS2_data,imm,PC, srcB_SEL, srcA_SEL,
              SEL_OP,
              Resultado,
              flagC,flagZ,flagError,flagNegativo);
initial begin
SEL_OP=4'b0000;
RS1_data=10;
RS2_data=7;
imm=4;
PC=12;
srcB_SEL=0;
srcA_SEL=0;
#40
srcB_SEL=1;
srcA_SEL=0;
#40
srcB_SEL=0;
srcA_SEL=1;
#40
srcB_SEL=1;
srcA_SEL=1;
end
endmodule