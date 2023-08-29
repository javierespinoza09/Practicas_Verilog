module contador8 (
input clk,rst,en,
output reg [2:0]cuenta
);

always @(posedge clk) begin
if (rst) cuenta<=0;
else if (en==0) cuenta<=cuenta;
else if ((cuenta <7)) cuenta<=cuenta+1;
else cuenta<=0;
end

endmodule