module RAM_WE_deco (input WE, input [31:0] addrs, output reg RAM_WE);
always @(*) begin
    if (addrs>=32'h00000800 | addrs<32'h000008fc) RAM_WE=WE;
    else RAM_WE=0;
end
endmodule