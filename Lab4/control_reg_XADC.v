module control_reg_XADC (input  [31:0] control_ext,input [1:0] control_int, input clk, rst, WE1,WE2, output [31:0]control_out);
reg [31:0] registro_control;
always @(posedge clk) begin
    if (rst) registro_control <= 0;
    else begin
        if (WE2) begin
            registro_control [1]<= control_int[1];
            registro_control [0]<= control_int[0];
        end
        else begin
            registro_control [0]<=registro_control [0];
            registro_control [15:8]<=registro_control [15:8];
            if (WE1) begin
                
                    registro_control [1] <= 1'b0;
                    registro_control [0] <= control_ext[0];
                    registro_control [15:8] <= control_ext [8:1];
            end
            else begin 
                registro_control <= registro_control;
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