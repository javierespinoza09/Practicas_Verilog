module param_mux #(parameter depth = 8, parameter bits = 4)(
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
