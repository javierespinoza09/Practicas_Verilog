module MUX_ALU_in (input [31:0]data_reg, aux, input OP_SEL,
                   output reg [31:0] OP);
always @(*) begin
    case (OP_SEL)
    0:OP=data_reg;
    1:OP=aux;
    endcase
end
endmodule