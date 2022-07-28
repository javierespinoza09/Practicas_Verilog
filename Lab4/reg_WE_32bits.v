module reg_WE_32bits (input [31:0] Data_in, input clk,rst, WE,
                      output [31:0] Data_o);
reg [31:0] Data;
always @(posedge clk) begin 
    if (rst) Data<=0;
    else begin
        if (WE) Data<=Data_in;
        else Data<=Data;
    end
end
assign Data_o=Data;
endmodule