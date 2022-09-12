`timescale 1ns/1ps
module TOP_tb ();

reg clk,rst,MISO,start,clear,EN;

wire MOSI,SS,CLK,ready;

wire [7:0] DatosOUT1,DatosOUT2;
reg  [7:0] DatosIN;



TOPSPI T1(.rst(rst),.clkfast(clk),.CLK(CLK),.MISO(MISO),.MOSI(MOSI),.EN(EN),.ready(ready),.clear(clear),.start(start),.DatosIN(DatosIN),/*.DatosOUT(DatosOUT1),*/.Anode_Control(DatosOUT1),.Cathode_Control(DatosOUT2),.SS(SS));

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
MISO=0;
rst=0; 
EN=0;
clear=0;
start=0;

#6300

DatosIN [7:0]=5;

rst=1;
EN=1;
#300
EN=0;
MISO=1;
#200
start=1;
#200
MISO=0;
#20000


#15
$finish;
end

endmodule