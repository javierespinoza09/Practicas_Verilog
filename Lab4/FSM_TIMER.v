module FSM_TIMER (
		input clk,rst,
		input bit_END_Entrada,
		input [3:0]fourbitsPeriodo_Entrada_REG,fourbitsPeriodo_Entrada_Counter,
	output reg rst_FSM,bit_END_Salida,WE_FSM, EN_FSM,
	output reg [3:0]fourbitsPeriodo_Salida
	);

//Definimos la cantidad de bits de estado
parameter BITS_ESTADO = 2;
reg [BITS_ESTADO-1:0] state, next_state;

//Codificación de los estados usando parameter
parameter ESTADO_ESPERA=0, ESTADO_CUENTA=1, ESTADO_LIMPIAR=2 ;

//Bloque de memoria (esto siempre es igual!!!)
always @(posedge clk) begin
    if(rst) state <= ESTADO_ESPERA; //rst ó !rst
    else state<=next_state;
end

//Lógica de siguiente estado (COMBINACIONAL!!!)
always @(*) begin
    case(state)
	//podemos usar if/else if/else ó case anidados
	ESTADO_ESPERA: begin
		if(bit_END_Entrada) next_state = ESTADO_CUENTA;
		else next_state =ESTADO_ESPERA;
          end

	//podemos saltar sin condiciones
	ESTADO_CUENTA: begin
	   if (fourbitsPeriodo_Entrada_Counter==fourbitsPeriodo_Salida) next_state=ESTADO_LIMPIAR;
	   else next_state=ESTADO_CUENTA;
	end

	ESTADO_LIMPIAR: next_state=ESTADO_ESPERA;	

	default:
	   next_state = ESTADO_ESPERA;
    endcase
end

//Lógica de salida (combinacional) – MEALEY!
always @(*) begin

    case(state)
	ESTADO_ESPERA:	begin
	           EN_FSM=0;
			   rst_FSM=1;
			   bit_END_Salida=0;
			   WE_FSM=0;
			   fourbitsPeriodo_Salida=fourbitsPeriodo_Entrada_REG;
			end 
    ESTADO_CUENTA:	begin
               EN_FSM=1;
		       rst_FSM=0;
		       bit_END_Salida=0;
		       WE_FSM=0;
			end 
	ESTADO_LIMPIAR: begin
	           EN_FSM=0;
	           rst_FSM=1;
		       bit_END_Salida=1;
		       WE_FSM=1;
		       fourbitsPeriodo_Salida=fourbitsPeriodo_Entrada_REG;
		     end
    endcase
end


endmodule 
