module timer_200ms #(parameter cuentamaxima=20)(
    input rst,clk,EN,
    output reg [21:0] cuenta,
    output reg EN_4bits
);
//2000000

always @(posedge clk) begin
    if (rst) cuenta<=0;
    else if(EN&&cuenta<cuentamaxima) cuenta<=cuenta+1;
    else if (cuenta>=cuentamaxima) cuenta<=0;
    else cuenta<=cuenta;
end

always @(*) begin
    if (cuenta==cuentamaxima)EN_4bits=1;
    else EN_4bits=0;
end


endmodule