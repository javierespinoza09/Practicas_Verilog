module reg_corrimiento (
input rst,clk, en, load, bitin, ln,
input [7:0] datosload, 
output reg [7:0] datos
);
reg bitinIN;


always @(posedge clk) begin
if (rst) begin datos<=0; bitinIN<=0; end
else if (load) datos<=datosload;
else if (en) datos<={ bitinIN, datos [7:1] };
else datos<=datos;
if (ln) bitinIN<=bitin;
end



endmodule