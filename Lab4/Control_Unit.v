module Control_Unit (input rst,clk,zero,lt, input [6:0] OPC, input [2:0] Func3, input [6:0] Func7,
                     output reg [3:0] ALU_OP, 
                     output reg SrcB_SEL, SrcA_SEL,fetch, output reg [1:0] Sel_Reg_In, PC_Control, 
                     output reg [2:0] imm_SEL, 
                     output reg RD_WE, WE, imm_extend_WE);

//Estado 2 => R-Suma// Estado 3 => R-Resta// Estado 4 => R-SLL// Estado 5 => R-XOR// Estado 6 => R-SRL// Estado 7 => R-SRA// Estado 8 => R-OR //Estado 9 => R-AND //Estado 10 => I-LW
parameter imm_I=0;
parameter imm_S=1;
parameter imm_B=2;
parameter imm_U=3;
parameter imm_J=4;
parameter imm_I_shamt=5;
//
parameter error=31;
parameter R_Type=7'b0110011;
parameter I_Type=7'b0010011;
parameter B_Type=7'b1100011;
parameter J_Type=7'b1101111;
parameter JR_Type=7'b1100111;
parameter IL_Type=7'b0000011;
parameter S_Type=7'b0100011;
parameter U_Type=7'b0110111;
//Estado
parameter R_Estado=2;
parameter I_Estado=3;
parameter B_Estado=4;
parameter J_Estado=5;
parameter JR_Estado=6;
parameter IL_Estado=7;
parameter S_Estado=12;
parameter U_Estado=13;
//Estados Branch
parameter BEQ=8;
parameter BNE=9;
parameter BLT=10;
parameter Branch=11;
parameter BGE=14;
//PC_Control//
parameter clear = 0;
parameter jump = 1;
parameter count = 2;
parameter hold = 3;
//
parameter fetch_Estado=0;
parameter decode=1;
parameter AUX=31; //Estado que continúa con la cuenta
reg [4:0] Estado_Control;
///////////////////Lógica de Siguiente Estado/////////////////////////
always @(posedge clk) begin
    if (rst) Estado_Control <= 0;
    else begin
        if (Estado_Control == fetch_Estado) Estado_Control <= decode; //Estado 1 => Decode
        else begin
                case (Estado_Control)
                    R_Estado: Estado_Control <= fetch_Estado;
                    I_Estado: Estado_Control <= fetch_Estado;
                    B_Estado: begin
                        case (Func3) 
                            0: Estado_Control <= BEQ;
                            1: Estado_Control <= BNE;
                            5: Estado_Control <= BGE;
                            4: Estado_Control <= BLT;
                            default: Estado_Control <= AUX;
                        endcase
                    end
                    BEQ: begin
                        if (zero) Estado_Control <= Branch;
                        else Estado_Control <= AUX;
                    end
                    BNE: begin
                        if (!zero) Estado_Control <= Branch;
                        else Estado_Control <= AUX;
                    end
                    BLT: begin
                        if (lt) Estado_Control <= Branch;
                        else Estado_Control <= AUX;
                    end
                    BGE: begin
                        if (!lt) Estado_Control <= Branch;
                        else Estado_Control <= AUX;
                    end
                    J_Estado: Estado_Control <= fetch_Estado;
                    JR_Estado: Estado_Control <= fetch_Estado;
                    IL_Estado: Estado_Control <= fetch_Estado;
                    S_Estado: Estado_Control <= fetch_Estado;
                    U_Estado: Estado_Control <= fetch_Estado;
                    Branch: Estado_Control <= fetch_Estado;
                    decode: begin
                        case (OPC)
                            R_Type: Estado_Control <= R_Estado; //Estado 2 => R-Type (ADD,SUB,AND,OR,XOR,SLL,SRL,SRA,SLT)
                            I_Type: Estado_Control <= I_Estado; //Estado 3 => I-Type
                            B_Type: Estado_Control <= B_Estado; //Estado 4 => B-Type
                            J_Type: Estado_Control <= J_Estado; //Estado 5=> J-Type (Jump to PC+imm, save link in rd)
                            JR_Type: Estado_Control <= JR_Estado; //Estado 6 => I-JALR (Jump to sr1+imm, save link in rd)
                            IL_Type: Estado_Control <= IL_Estado; // Estado 7 => IL-LW
                            U_Type: Estado_Control <= U_Estado; // Estado 13 => U-LUI
                            S_Type: Estado_Control <= S_Estado; // Estado 12 => S-SW
                            default: Estado_Control <= AUX;
                        endcase
                    end
                    AUX: Estado_Control <= fetch_Estado;
                    default: Estado_Control <= fetch_Estado;
                endcase
        end
    end
end
always @(*) begin
        case (Estado_Control)
            AUX:begin 
                fetch=0;
                ALU_OP=0;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=count; 
                imm_SEL=0;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;  
            end
            fetch_Estado: begin 
                fetch=1;
                ALU_OP=0;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=hold; 
                imm_SEL=0;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;  
            end
            decode: begin 
                fetch=0;
                ALU_OP=0;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=hold; 
                RD_WE=0;
                WE=0;
                imm_extend_WE=1; 
                case (OPC)
                    I_Type: begin
                        imm_SEL=0; 
                    end
                    S_Type:begin
                        imm_SEL=1; 
                    end 
                    B_Type:begin
                        imm_SEL=2; 
                    end 
                    U_Type: begin
                        imm_SEL=3; 
                    end
                    J_Type: begin
                        imm_SEL=4; 
                    end
                    JR_Type: begin
                        imm_SEL=0; 
                    end
                    IL_Type: begin
                        imm_SEL=0; 
                    end
                    default:  imm_SEL=0;                   
                endcase
            end
            R_Estado: begin 
                fetch=0;
                ALU_OP={Func7[5], Func3};
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=count; 
                imm_SEL=0;
                RD_WE=1;
                WE=0;
                imm_extend_WE=0;  
            end
            I_Estado: begin 
                fetch=0;
                SrcB_SEL=1; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=count; 
                imm_SEL=1;
                RD_WE=1;
                WE=0;
                imm_extend_WE=0;  
                if (Func3==3'b101)ALU_OP={Func7[5], Func3};
                else ALU_OP={1'b0, Func3};
            end
            J_Estado:begin 
                fetch=0;
                ALU_OP=4'b0000;
                SrcB_SEL=1; 
                SrcA_SEL=1;
                Sel_Reg_In=3; 
                PC_Control=jump; 
                imm_SEL=4;
                RD_WE=1;
                WE=0;
                imm_extend_WE=0;  
            end
            BEQ:begin
                fetch=0;
                ALU_OP=4'b1000;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=hold; 
                imm_SEL=2;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;  
            end
            BNE:begin
                fetch=0;
                ALU_OP=4'b1000;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=hold; 
                imm_SEL=2;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;  
            end
            BLT:begin
                fetch=0;
                ALU_OP=4'b1000;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=hold; 
                imm_SEL=2;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;  
            end  
            BGE:begin
                fetch=0;
                ALU_OP=4'b1000;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=hold; 
                imm_SEL=2;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;  
            end 
            Branch:begin
                fetch=0;
                ALU_OP=4'b0000;
                SrcB_SEL=1; 
                SrcA_SEL=1;
                Sel_Reg_In=0; 
                PC_Control=jump; 
                imm_SEL=2;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;
            end                  
            JR_Estado:begin
                fetch=0;
                ALU_OP=4'b0000;
                SrcB_SEL=1; 
                SrcA_SEL=0;
                Sel_Reg_In=3;
                PC_Control=jump; 
                imm_SEL=3;
                RD_WE=1;
                WE=0;
                imm_extend_WE=0;
            end
            IL_Estado:begin
                fetch=0;
                ALU_OP=4'b0000;
                SrcB_SEL=1;
                SrcA_SEL=0;
                Sel_Reg_In=2; 
                PC_Control=count; 
                imm_SEL=0;
                RD_WE=1;
                WE=0;
                imm_extend_WE=0;
            end
            U_Estado:begin 
                fetch=0;
                ALU_OP=4'b0000;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=1; 
                PC_Control=count; 
                imm_SEL=3;
                RD_WE=1;
                WE=0;
                imm_extend_WE=0;
            end
            S_Estado:begin 
                fetch=0;
                ALU_OP=4'b0000;
                SrcB_SEL=1; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=count; 
                imm_SEL=3;
                RD_WE=0;
                WE=1;
                imm_extend_WE=0;
            end
            default: begin fetch=0;
                ALU_OP=4'b0000;
                SrcB_SEL=0; 
                SrcA_SEL=0;
                Sel_Reg_In=0; 
                PC_Control=hold; 
                imm_SEL=0;
                RD_WE=0;
                WE=0;
                imm_extend_WE=0;
            end
        endcase
end
endmodule
//            0:o_imm = imm_I;
//            1:o_imm = imm_S;
//            2:o_imm = imm_B;
//            3:o_imm = imm_U;
//            4:o_imm = imm_J;
//            5:o_imm = imm_I_shamt;