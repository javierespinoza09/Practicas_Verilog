module Instr_reg (input [31:0] in_instruction, 
                    input fetch,rst,clk, 
                    output  [31:0] fetched_instr);
    reg [31:0] Instruction;
    always @(posedge clk) begin
        if (rst) Instruction<=0;
        else begin
            if (fetch) Instruction<=in_instruction;
            else Instruction<=Instruction;
        end
    end
    assign fetched_instr = Instruction;
endmodule 