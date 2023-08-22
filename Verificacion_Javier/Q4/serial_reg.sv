module serial_reg #(parameter depth = 8, parameter bits = 4)(
input push,
  input [bits-1:0] D_in,
input reset,
  output [bits-1:0] D_out [depth-1:0]
);
  genvar i;
  generate 
    for (i=0;i<depth;i=i+1)begin
      if(i == 0) begin
        dff_arst dff_(.D(D_in),.rst(reset),.clk(push),.Q(D_out[i]));
      end else begin
        dff_arst dff_(.D(D_out[i-1]),.rst(reset),.clk(push),.Q(D_out[i]));
      end 
    end
    
  endgenerate 
