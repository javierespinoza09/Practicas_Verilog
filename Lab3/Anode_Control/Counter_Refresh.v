module Counter_Refresh (input clk, EN, rst, output reg [2:0] Count_Out);
    reg [2:0] state;
    reg [2:0] nextstate;
    
    always @(posedge clk) begin
        if (rst) state <= 0;
        else begin 
            if (EN==1) begin
                if (state<8) state <= nextstate;
                else state <= 0;
            end
            else state <= state;
        end
    end
    
    always @(*) begin
        nextstate = state+1;
        Count_Out = state;
    end
endmodule