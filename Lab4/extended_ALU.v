module extended_ALU (input [31:0] RS1_data, RS2_data,imm,PC, input srcB_SEL, srcA_SEL,
                     input [3:0]SEL_OP,
                     output [31:0] Resultado,
                     output flagC,flagZ,flagError,flagNegativo);
wire [31:0] srcA,srcB;
MUX_ALU_in ALU_A (.data_reg(RS1_data), .aux(PC), .OP_SEL(srcA_SEL),
                  .OP(srcA));
MUX_ALU_in ALU_B (.data_reg(RS2_data), .aux(imm), .OP_SEL(srcB_SEL),
                  .OP(srcB));
ALU A(.A(srcA),.B(srcB),
.SELOP(SEL_OP),
.Resultado(Resultado),
.flagC(flagC),.flagZ(flagZ),.flagError(flagError),.flagNegativo(flagNegativo)
);
endmodule