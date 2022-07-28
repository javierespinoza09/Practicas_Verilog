module Splice (input [31:0] full_intruc, output [6:0] OPC, 
                [6:0] func7, output [2:0] func3,
                output [31:0] imm_S,
                output [31:0] imm_I,
                output [31:0] imm_I_shamt,
                output [31:0] imm_B,
                output [31:0] imm_J,
                output [31:0] imm_U,
                output [4:0] RS1,RS2,RD);
    assign OPC = full_intruc [6:0];
    assign func7 = full_intruc [31:25];
    assign func3 = full_intruc [14:12];
    assign imm_B = {{20{full_intruc[31]}}, full_intruc[7],full_intruc[30:25], full_intruc[11:8],1'b0};
    assign imm_S = {{21{full_intruc[31]}}, full_intruc[30:25], full_intruc[11:7]};
    assign imm_J = {{12{full_intruc[31]}}, full_intruc[19:12], full_intruc[20], full_intruc[30:21],1'b0};
    assign imm_I = {{21{full_intruc[31]}}, full_intruc[30:20]};
    assign imm_I_shamt = {27'b0, full_intruc[24:20]};
    assign imm_U = {full_intruc[31:12],12'b0};
    assign RD=full_intruc[11:7];
    assign RS1=full_intruc[19:15];
    assign RS2=full_intruc[24:20];
    
endmodule 