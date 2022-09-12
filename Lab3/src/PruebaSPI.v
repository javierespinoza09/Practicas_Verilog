module PruebaSPI (
input clk,rst,start,
input [7:0]datoIN, 
input MISO,
output reg MOSI,SS,
output reg CLK,
output reg [7:0] datoOUT
);

wire [2:0]cuenta;

wire negclk;
reg rst2;
wire pulso;
reg [7:0]dataOUT,dataIN;
wire clk_out1;

contador8 C1(.clk(clk_out1),.rst(rst2),.cuenta(cuenta));
assign negclk=~clk_out1;


clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
   // Clock in ports
    .clk_in1(clk));      // input clk_in1   */


GPulso G1(.clk(negclk),.rst(rst),.in(start),.out(pulso));

parameter BITS_ESTADO = 2;
reg [BITS_ESTADO-1:0] state, next_state;


parameter ESTADO_Espera ='b00, ESTADO_trans='b01,ESTADO_bit0='b10;

always @(posedge clk_out1) begin
    if(!rst) state <= ESTADO_Espera; 
    else state<=next_state;
end

always @(*) begin
    case(state)

	ESTADO_Espera: begin
		if(pulso) next_state = ESTADO_bit0;
		else next_state =ESTADO_Espera;
          end
    ESTADO_trans: begin
   if (cuenta<7)next_state = ESTADO_trans;
   else begin 
   next_state =ESTADO_Espera;
  
   end
    end
    ESTADO_bit0: begin
     next_state = ESTADO_trans;

  
   end


	default:
	   next_state = ESTADO_Espera;
    endcase
end

always @(*) begin
    dataIN=datoIN;
    datoOUT=dataOUT;
    
    case(state)
	 ESTADO_Espera:	begin
			   MOSI = 0;
			   SS=1;
			   rst2=0;
			   CLK=0;

			end 
     ESTADO_trans:	begin
		       MOSI=dataIN[cuenta];
		       CLK=clk_out1;
		       SS=0;
		       rst2=1;
			end 
	ESTADO_bit0: begin
	           MOSI=dataIN[0];
		       CLK=0;
		       rst2=0;
	           end

    endcase
end
always @(negedge clk_out1) begin
if (state==ESTADO_trans)begin 
dataOUT[cuenta]<=MISO;
end
if (state==ESTADO_bit0)begin 
SS<=0;
end
end


endmodule