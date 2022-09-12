module clock_divider_reg (input clk, rst, output reg clk_slow_reg, [1:0] speed);

 reg [25:0] state;
 reg [25:0] nextstate;

always@(posedge clk) begin
    if(rst) state<=0;
    else begin
	   state <= nextstate;
	end
end

always @(*) begin
    case(speed)
    0:  begin 
            if(state<10000000) begin 
                nextstate=state+1; 
                clk_slow_reg = 0; 
            end  
            else begin
                clk_slow_reg = 1;
                nextstate=state+1;
                if(state>20000000) begin 
                    nextstate=0;  
                end 
            end 
        end
    1: begin 
            if(state<5000000) begin 
                nextstate=state+1; 
                clk_slow_reg = 0; 
            end  
            else begin
                clk_slow_reg = 1;
                nextstate=state+1;
                if(state>10000000) begin 
                    nextstate=0;  
                end 
            end 
        end
    2: begin 
            if(state<2500000) begin 
                nextstate=state+1; 
                clk_slow_reg = 0; 
            end  
            else begin
                clk_slow_reg = 1;
                nextstate=state+1;
                if(state>5000000) begin 
                    nextstate=0;  
                end 
            end 
        end
    3: clk_slow_reg = 0;
    endcase    
end
endmodule