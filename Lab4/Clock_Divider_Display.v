module Clock_Divider_Display (input clk, rst, output reg clk_slow);


 reg [11:0] state;
 reg [11:0] nextstate;
 


always@(posedge clk) begin
    if(rst) state<=0;
    else begin
	   state <= nextstate;
	end
end

always @(*) begin
    if(state<4095) begin 
        nextstate=state+1; 
        clk_slow = 0; 
    end  
    else begin
        nextstate = 0;
        clk_slow = 1;
    end
end
endmodule