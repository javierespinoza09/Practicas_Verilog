`timescale 1ns/1ps
module PruebaSPI_tb();

reg clk,rst,MISO;
//reg [7:0] datoIN;
wire MOSI,SS,CLK;
//wire [7:0] datoOUT;
//PruebaSPI P1(.clk(clk),.rst(rst),.start(start),.datoOUT(datoOUT),.datoIN(datoIN),.MISO(MISO), .MOSI(MOSI),.SS(SS)/*,.CLK(CLK)*/);

reg [31:0] OUTControl,OUTDatos;

wire [31:0] IN2Control,IN2Datos;
wire WR2,WR1;


ControlSPI P1(.clk(clk),.rst(rst),.OUTControl(OUTControl),.OUTDatos(OUTDatos),.IN2Control(IN2Control),.MISO(MISO), .MOSI(MOSI),.SS(SS),.IN2Datos(IN2Datos),.WR1(WR1),.WR2(WR2),.CLK(CLK));
initial begin



forever begin
	#5
	clk=~clk;

end

end

initial begin
assign MISO=MOSI;

OUTControl=0;
OUTDatos=0;
clk=0;
MISO=0;
rst=0; 

#60

OUTDatos [7:0]=5;
rst=1;
#20
OUTControl[0]=1;
#2000


#15
$finish;
end

endmodule