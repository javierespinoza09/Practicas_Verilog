module GeneradorCLKyPulsos (
input clk, rst,
output reg CLK, lp,ln
);

reg [3:0] cuenta ;




always @(posedge clk) begin
if (rst) cuenta<=0;
else if (cuenta<9) cuenta<=cuenta+1;
else cuenta<=0;

end

always @(*) begin
 
 if (cuenta<5) begin
 CLK=0;
 end
 else begin
 CLK=1;
 end
 
 if (cuenta==4) lp=1;
 else lp=0;
 if (cuenta==9) ln=1;
 else ln=0;

end


endmodule


