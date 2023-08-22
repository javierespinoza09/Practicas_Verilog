`timescale 1ns/10ps
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
