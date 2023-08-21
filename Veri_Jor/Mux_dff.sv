// Code your design here
// Code your design here
module dff_arst #(parameter bits = 4) (
  input [bits-1:0] D, 
  input rst, clk,
  output reg [bits-1:0] Q
		);
  always@(posedge clk, posedge rst) begin
    if(rst) Q <= 0;
	else Q <= D;
end
endmodule


module mux_dff #(parameter depth = 8, parameter bits = 4)(
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
  
  
endmodule

module salida #(parameter depth = 8, parameter bits = 4)(
  input [bits-1:0] Data_in [depth-1:0],
  input [bits-1:0] pc,
  output reg [bits-1:0] Data_out);
  
  always_comb begin
    case(pc)
      0: Data_out =0;
      default: Data_out = Data_in[pc-1];
    endcase 
  end 
  
  
  
endmodule 




// Code your design here
module control #(parameter bits = 4, parameter depth = 8) (
input reset,
input push,
input pop,
input clk,
output push_out,
  output reg [$clog2(depth):0] pc);
  parameter stay = 3'b000, out = 3'b001, add = 3'b010, actual = 3'b011, rst = 3'b100, empty = 3'b101, addone = 3'b111, zero = 3'b110 ;  
  
  always @(posedge clk) begin
    case ({reset,push,pop})
      stay : pc = pc;
      empty : pc = 0;
      rst : pc = 0;
      add : pc = (pc == depth-1)? pc:pc+1;
      out : pc = (pc == 0)? 0:pc-1;
      actual : pc = pc;
      addone : pc = 1;
      zero : pc = 0;
      
    endcase
    
  end
  assign push_out = push;
endmodule