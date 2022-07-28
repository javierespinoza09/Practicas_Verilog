module data_reg_XADC (input [11:0] data, input WE2,clk,rst, output [31:0] data_reg_out);
reg [31:0] data_reg;
always @(posedge clk) begin
    if (rst) data_reg<=0;
    else begin
        if (WE2) begin
            data_reg[11:0] <= data;
        end
        else data_reg[11:0] <= data_reg[11:0];
    end
    data_reg[31:12]<=0;
end
assign data_reg_out={20'b0,data_reg};
endmodule