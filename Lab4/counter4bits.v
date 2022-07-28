module counter4bits (
    input rst,clk,EN,
    output reg [3:0] cuenta 
);

always @(posedge clk) begin
    if (rst) cuenta<=0;
    else if (EN&&cuenta<15) cuenta<=cuenta+1;
    else if (cuenta>=15) cuenta<=0;
    else cuenta<=cuenta;
end

endmodule