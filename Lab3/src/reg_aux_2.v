module reg_aux_2 (input [31:0] Data_SPI, input WE_aux2,clk,rst, output [31:0]cont_aux2);
reg [31:0]aux2;
always @(posedge clk) begin
    if (rst) aux2 <= 0;
    else begin
        if (WE_aux2) aux2 <= Data_SPI;
        else aux2 <= aux2;
    end
end
assign cont_aux2=aux2;
endmodule