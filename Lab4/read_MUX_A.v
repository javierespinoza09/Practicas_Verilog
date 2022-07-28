module read_MUX_A (input addres8,input [31:0] data_RAM, [31:0] data_perif, 
                   output reg [31:0] read_data);
always @(*) begin
    case (addres8)
    0:read_data=data_RAM;
    1:read_data=data_perif;
   
    endcase
end
endmodule 