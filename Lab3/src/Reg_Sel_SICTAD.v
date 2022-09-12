module Reg_Sel_SICTAD (input [32:0] Reg_0,Reg_1, input SEL, output reg [3:0] Salida_0,Salida_1,Salida_2,Salida_3
                                                                     ,Salida_4,Salida_5,Salida_6,Salida_7);
always @(*) begin
        case(SEL)
            0: begin
                    Salida_0=Reg_0[3:0];
                    Salida_1=Reg_0[7:4];
                    Salida_2=Reg_0[11:8];
                    Salida_3=Reg_0[15:12];
                    Salida_4=Reg_0[19:16];
                    Salida_5=Reg_0[23:20];
                    Salida_6=Reg_0[27:24];
                    Salida_7=Reg_0[31:28];                    
                end 
            1: begin
                    Salida_0=Reg_1[3:0];
                    Salida_1=Reg_1[7:4];
                    Salida_2=Reg_1[11:8];
                    Salida_3=Reg_1[15:12];
                    Salida_4=Reg_1[19:16];
                    Salida_5=Reg_1[23:20];
                    Salida_6=Reg_1[27:24];
                    Salida_7=Reg_1[31:28]; 
                end
        endcase
    end
endmodule