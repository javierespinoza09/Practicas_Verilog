
module BCD_Decoder (input [3:0] BCD_Decoder_In, 
                     output [6:0] BCD_Decoder_Out);
wire A,B,C,D,E,F,G;
led_A M1 (.SW(BCD_Decoder_In), .A(A));
led_B M2 (.SW(BCD_Decoder_In), .B(B));
led_C M3 (.SW(BCD_Decoder_In), .C(C));
led_D M4 (.SW(BCD_Decoder_In), .D(D));
led_E M5 (.SW(BCD_Decoder_In), .E(E));
led_F M6 (.SW(BCD_Decoder_In), .F(F));
led_G M7 (.SW(BCD_Decoder_In), .G(G));
assign BCD_Decoder_Out = {G,F,E,D,C,B,A};

endmodule