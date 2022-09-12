module reg_aux_1 (input [31:0] Data_XADC, input WE_aux1,clk,rst, output [31:0]cont_aux1);
reg [31:0]aux1;
always @(posedge clk) begin
    if (rst) aux1 <= 0;
    else begin
        if (WE_aux1) aux1 <= Data_XADC;
        else aux1 <= aux1;
    end
end
assign cont_aux1=aux1;
endmodule