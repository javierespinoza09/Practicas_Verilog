`timescale 1ns/1ps
module SPImodule_tb ();

reg clk,rst,MISO,regsel,wr;

wire MOSI,SS,CLK;
wire [31:0] Salida;

reg  [31:0] DatosIN;



SPImodule S1(.clkfast(clk),.rst(rst),.MISO(MISO),.RegSel(regsel),.WR(wr),
.DatosIN(DatosIN),
.SalidaMUX(Salida), 
.MOSI(MOSI),.SS(SS),.SCLK(CLK));

initial begin



forever begin
	#5
	clk=~clk;

end

end

initial begin

MISO=0;
DatosIN=0;
clk=0;
wr=0;
rst=0; 
regsel=0;


#630

DatosIN [7:0]=5;

rst=1;

#300
wr=1;
regsel=1;
#15
wr=0;
MISO=1;
regsel=0;
DatosIN[0]=1;
wr=1;
#15
wr=0;
#200

#200
MISO=0;
#2000


#15
$finish;
end

endmodule