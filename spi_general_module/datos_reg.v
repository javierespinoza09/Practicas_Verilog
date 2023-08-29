module datos_reg (
input  [31:0] IN1 ,IN2,
input clk, rst, WR1,WR2, 
output [31:0]datos_out);
reg [31:0] registro_datos;
always @(posedge clk) begin
    if (rst) registro_datos <= 0;
    else begin
        if (WR2) begin
                registro_datos [11:0]<=IN2 [11:0];
                end
        else begin

            registro_datos [11:0]<=registro_datos [11:0];
            if (WR1) begin
                    registro_datos [11:0]<=IN1 [11:0];
                    end
        end  
    end 
end
assign datos_out = {  20'b0,
                        registro_datos [11:0]
                        };
endmodule