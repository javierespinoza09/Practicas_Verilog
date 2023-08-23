module dff_arst #(parameter bits = 4) ( //modulo para declarar los flops, bits es el tamaño de la palabra
  input [bits-1:0] D, 
  input rst, clk,
  output reg [bits-1:0] Q
		);
  always@(posedge clk, posedge rst) begin //para ambas señales se usan los flancos positivos
    if(rst) Q <= 0;
	else Q <= D;
end
endmodule


module reg_dff #(parameter depth = 8, parameter bits = 4)( //arreglo de flops, depth es la profundidades y bits el tamaño de la palabra
input push,
  input [bits-1:0] D_in,
input reset,
  output [bits-1:0] D_out [depth-1:0] //la salida es empaquetada, es un arreglo de "depth" cantidad de flops con palabras de tamaño "bits"
);
  genvar i; 
  generate 
    for (i=0;i<depth;i=i+1)begin //ciclo para instanciar los flops
      if(i == 0) begin
        dff_arst dff_(.D(D_in),.rst(reset),.clk(push),.Q(D_out[i])); //declara que el primer flop recibe la información inicial
      end else begin
        dff_arst dff_(.D(D_out[i-1]),.rst(reset),.clk(push),.Q(D_out[i]));//el resto de flops tiene como entrada la salida del anterior
      end 
    end
    
  endgenerate 
  
  
endmodule

module salida #(parameter depth = 8, parameter bits = 4)( //mux para indicar la salida del sistema usando la misma profundidad y tamaño de palabras
  input [bits-1:0] Data_in [depth-1:0], 
  input [bits-1:0] pc,
  output reg [bits-1:0] Data_out); //la salida es solo para un dato por eso usa solo el parametro bits
  
  always_comb begin
    case(pc)
      0: Data_out =0;
      default: Data_out = Data_in[pc-1]; //usa -1 debido a que el valor 0 se le asigna a un reset, pero si hay un índice 0 en el arreglo 
    endcase 
  end 
  
  
  
endmodule 



module control #(parameter bits = 4, parameter depth = 8) ( //sistema de control para el sistema
input reset,
input push,
input pop,
input clk,
output push_out,
  output reg [$clog2(depth):0] pc); //pc es el selector del mux y su tamaño depende de los bits necesarios según la profundidad "depth"
  parameter stay = 3'b000, out = 3'b001, add = 3'b010, actual = 3'b011, rst = 3'b100, empty = 3'b101, addone = 3'b111, zero = 3'b110 ;  //estados para la maquina de control
  
  always @(posedge clk) begin
    case ({reset,push,pop}) //se concatenan las entradas para generar el case de las 3
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
  assign push_out = push; //asigna la señal de push en la entrada para usarla como el clk de los flops
endmodule