module Anode_Control (input [2:0] SEL, output reg [7:0] Anode_Control_Out);
    always @(*) begin
        case (SEL)
            0:Anode_Control_Out=8'b01111111;
            1:Anode_Control_Out=8'b10111111;
            2:Anode_Control_Out=8'b11011111;
            3:Anode_Control_Out=8'b11101111;
            4:Anode_Control_Out=8'b11110111;
            5:Anode_Control_Out=8'b11111011;
            6:Anode_Control_Out=8'b11111101;
            7:Anode_Control_Out=8'b11111110;   
        endcase 
    end
endmodule 