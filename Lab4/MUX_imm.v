module MUX_imm (input [31:0] imm_I,imm_I_shamt, imm_S, imm_B, imm_U, imm_J,input [2:0] imm_SEL, 
                output reg [31:0]o_imm);
    always @(*) begin
        case (imm_SEL) 
            0:o_imm = imm_I;
            1:o_imm = imm_S;
            2:o_imm = imm_B;
            3:o_imm = imm_U;
            4:o_imm = imm_J;
            5:o_imm = imm_I_shamt;
            default: o_imm = 0;
        endcase
    end

endmodule