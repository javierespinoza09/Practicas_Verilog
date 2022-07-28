module imm_extend (input [31:0]imm_in, input clk,rst,imm_extend_EN, output [31:0] imm_out);
reg [31:0]imm;
always @(posedge clk) begin
    if (rst) imm<=0;
    else begin 
        if (imm_extend_EN) imm <= imm_in;
        else imm <= imm;
    end
end
assign imm_out = imm;
endmodule