module WE_Regster #(parameter ANCHO=4) (input [31:0] Data,
                                        input rst,
                                        input EN,
                                        input clk,
                                        output reg [31:0] Reg_Out0
                                        );
reg [31:0] state;


always @(posedge clk) begin
    if (rst) begin
        state <= 0;

    end
    else begin
        if (EN==1) begin 
            state <= Data;

        end
        else begin
            state <= state;
        end
    end
end 
always @(*) begin
    Reg_Out0=state;
end
endmodule