module GPulso (
		input clk,rst,
		input in,
	output reg out);

parameter BITS_ESTADO = 2;
reg [BITS_ESTADO-1:0] state, next_state;

parameter ESTADO_espere1 ='b00, ESTADO_genere='b01, ESTADO_espere0='b11 ;

always @(posedge clk) begin
    if(rst) state <= ESTADO_espere1; 
    else state<=next_state;
end

always @(*) begin
    case(state)

	ESTADO_espere1: begin
		if(in) next_state = ESTADO_genere;
		else next_state =ESTADO_espere1;
          end

	ESTADO_genere: begin
		if(in) next_state = ESTADO_espere0;
		else next_state =ESTADO_espere1;
          end

	ESTADO_espere0: begin
		if(in) next_state = ESTADO_espere0;
		else next_state =ESTADO_espere1;
          end
	
	default:
	   next_state = ESTADO_espere1;
    endcase
end

always @(*) begin
    case(state)
	 ESTADO_espere1:out=0;
     ESTADO_genere:out=1;		
     ESTADO_espere0: out=0;
    endcase
end

endmodule 