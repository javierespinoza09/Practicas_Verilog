module Reg_Sel (input [15:0] Reg_0,Reg_1, input SEL, output reg [3:0] Salida_0,Salida_1,Salida_2,Salida_3);
always @(*) begin
        case(SEL)
            0: begin
                    Salida_0=Reg_0[3:0];
                    Salida_1=Reg_0[7:4];
                    Salida_2=Reg_0[11:8];
                    Salida_3=Reg_0[15:12];
                end 
            1: begin
                    Salida_0=Reg_1[3:0];
                    Salida_1=Reg_1[7:4];
                    Salida_2=Reg_1[11:8];
                    Salida_3=Reg_1[15:12];
                end
        endcase
    end
endmodule