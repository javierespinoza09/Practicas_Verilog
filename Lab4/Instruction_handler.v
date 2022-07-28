module Instruction_handler (input clk,rst, fetch, imm_extend_WE,
                            input [2:0] imm_SEL, 
                            input [31:0]in_instruction,
                            output [4:0] RS1,RS2,RD,
                            output [31:0] imm_out,
                            output [6:0] OPC, [6:0] func7, 
                            output [2:0] func3);
wire [31:0]fetched_instr; 
wire [31:0] imm_S,imm_I,imm_I_shamt,imm_B,imm_J,imm_U;
wire [31:0] o_imm;
                         
Instr_reg R0 (.in_instruction(in_instruction), 
              .fetch(fetch),.rst(rst),.clk(clk), 
              .fetched_instr(fetched_instr));
Splice U0 (.full_intruc(fetched_instr), .OPC(OPC), 
           .func7(func7), .func3(func3),
           .imm_S(imm_S),.imm_I(imm_I),.imm_I_shamt(imm_I_shamt),.imm_B(imm_B),.imm_J(imm_J),.imm_U(imm_U),
           .RS1(RS1),.RS2(RS2),.RD(RD));
MUX_imm MUX0 (.imm_I(imm_I),.imm_I_shamt(imm_I_shamt), .imm_S(imm_S), .imm_B(imm_B), .imm_U(imm_U), .imm_J(imm_J),
              .imm_SEL(imm_SEL),.o_imm(o_imm));  
imm_extend IMM (.imm_in(o_imm),.clk(clk),.rst(rst),.imm_extend_EN(imm_extend_WE), 
            .imm_out(imm_out));            
endmodule 