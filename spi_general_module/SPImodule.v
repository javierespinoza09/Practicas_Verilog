/*

SPImodule S1(.clkfast(clk),.rst(rst),.MISO(MISO),.RegSel(),.WR(),
.DatosIN(),
.SalidaMUX(), 
.MOSI(MOSI),.SS(SS),.SCLK(CLK));

Modulos que necesita:

control_reg.v
datos_reg.v
demux1a2.v
mux2a1.v
ControlSPI.v
GeneradorCLKyPulsos.v
contador8.v
reg_corrimiento.v

*/

module SPImodule (
input clkfast,rst,MISO,RegSel,WR,
input [31:0] DatosIN,
output [31:0] SalidaMUX, 
output MOSI,SS,SCLK
);

wire [31:0] IN2Control, IN2Datos, OUTControl, OUTDatos;


wire WR2Datos,WR2Control,WR1Datos,WR1Control;


wire Salida0DEMUX, Salida1DEMUX;


control_reg C1(.clk(clkfast),.rst(rst),.IN1(DatosIN),.IN2(IN2Control),.WR1(Salida0DEMUX),.WR2(WR2Control),.control_out(OUTControl));
datos_reg D1(.clk(clkfast),.rst(rst),.IN1(DatosIN),.IN2(IN2Datos),.WR1(Salida1DEMUX),.WR2(WR2Datos),.datos_out(OUTDatos));

demux1a2 d1(.Entrada(WR),.SEL(RegSel),.Salida0(Salida0DEMUX),.Salida1(Salida1DEMUX));
mux2a1 m1(.Entrada0(OUTControl),.Entrada1(OUTDatos),.SEL(RegSel),.Salida(SalidaMUX));

ControlSPI S1(.rst(rst),.clk(clkfast),.CLK(SCLK),.MOSI(MOSI),.MISO(MISO),.OUTControl(OUTControl),.OUTDatos(OUTDatos),.IN2Control(IN2Control),.IN2Datos(IN2Datos),.SS(SS),.WR2Control(WR2Control),.WR2Datos(WR2Datos));




endmodule