module control_reg (
input  [31:0] IN1 ,IN2,
input clk, rst, WR1,WR2, 
output [31:0]control_out);
reg [31:0] registro_control;
always @(posedge clk) begin
    if (rst) registro_control <= 0;
    else begin
        if (WR2) begin
                registro_control [0]<=IN2 [0];
                registro_control [1]<=IN2 [1];
                registro_control [15:8]<=IN2 [15:8];
                end
        else begin
            registro_control [0]<=registro_control [0];
            registro_control [15:8]<=registro_control [15:8];
            if (WR1) begin
                    registro_control [1:0]<= IN1[1:0];
                    registro_control [15:8]<= 8'b0;
                    end
        end     
    end 
end
assign control_out = {  16'b0,
                        registro_control [15:8],
                        6'b0,
                        registro_control [1],
                        registro_control [0]
                        };
endmodule