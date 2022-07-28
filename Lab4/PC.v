module PC (input clk, rst,
           input [1:0] SEL,
           input [31:0] jump_dir,
           output [31:0] PC_out,
           output [31:0] PC_inc);   
              
reg [31:0] Current_Count;
reg [31:0] Next_Count;

always @(posedge clk) begin
    if (rst) begin
        Current_Count<=0;
    end
    else  Current_Count<=Next_Count;
    
end
always @(*) begin
     case (SEL)
        0:Next_Count=0;
        1:Next_Count=jump_dir;
        2:Next_Count=Current_Count+4;
        3:Next_Count=Current_Count;          
    endcase
end
assign PC_out=Current_Count;
assign PC_inc=Current_Count+4;
endmodule 