module dff_arst (
		input D, rst, clk,
		output reg Q
		);
always@(posedge clk, negedge rst) begin
	if(!rst) Q <= 1'b0;
	else Q <= D;
end
endmodule


module mux_dff #(parameter bits = 8)(
input push,
input D_in,
input reset,
output [bits-1:0] D_out
);
  genvar i;
  generate 
    for (i=0;i<bits;i=i+1)begin
      if(i == 0) begin
        dff_arst dff_(.D(D_in),.rst(reset),.clk(push),.Q(D_out[i]));
      end else begin
        dff_arst dff_(.D(D_out[i-1]),.rst(reset),.clk(push),.Q(D_out[i]));
      end 
    end
    
  endgenerate 
  
  
endmodule

module salida #(parameter depth = 8, parameter bits = 1)(
input [depth-1:0] Data_in,
input [3:0] pc,
input clk,
output reg Data_out);
  
  always@(posedge clk)begin
    case(pc)
      0: Data_out<=0;
      default: Data_out <= Data_in[pc-1];
    endcase 
  end 
  
  
  
endmodule 