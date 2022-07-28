module BloqueTimer (
    input rst,clk,WE,
    input [31:0] Entrada,
    output [31:0] Salida
);
reg [31:0]Entrada_if;
wire [31:0] Salida_REG;
wire [3:0] cuenta_4bits,fourbitsPeriodo_Salida;
wire EN_4bits,rst_counters,rst_FSM,WE_FSM,bit_END_Salida,EN_FSM;

assign rst_counters=rst|rst_FSM;
counter4bits fourbits(.rst(rst_counters),.clk(clk),.EN(EN_4bits&EN_FSM),.cuenta(cuenta_4bits));
timer_200ms timer200(.rst(rst_counters),.clk(clk),.cuenta(),.EN(1),.EN_4bits(EN_4bits));

FSM_TIMER FSMT(.rst(rst),.clk(clk),.bit_END_Entrada(Salida_REG[4]),
.fourbitsPeriodo_Entrada_REG(Salida_REG[3:0]),.fourbitsPeriodo_Salida(fourbitsPeriodo_Salida),
.WE_FSM(WE_FSM),.rst_FSM(rst_FSM),.EN_FSM(EN_FSM),.fourbitsPeriodo_Entrada_Counter(cuenta_4bits),.bit_END_Salida(bit_END_Salida));

bitsReg32 reg32Timer(.rst(rst),.WE(WE_FSM|WE),.clk(clk),.Entrada(Entrada_if),.Salida(Salida_REG));
assign Salida=Salida_REG;
always @(*) begin 
    if (WE) Entrada_if=Entrada;
    else if (WE_FSM) Entrada_if={27'b0,bit_END_Salida,fourbitsPeriodo_Salida};
    else Entrada_if=Entrada;
end

endmodule