module CompletarTecladoOUT(
    input [3:0] IN,
    output [31:0] OUT
);

assign OUT[31:0] = {{28{1'b0}},IN[3:0]};
endmodule