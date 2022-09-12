module SICTAD (input clk,rst,EN, input vauxn2,vauxp2, MISO, output MOSI,SS,SCLK,Flag,
                output [6:0] seg, output [7:0] an);
                
wire [31:0]XADC_out, SPI_out, cont_aux1,cont_aux2;
wire WE_aux1,WE_aux2,clk_out,OutFlag;
wire OutNew,OutSend;
wire SelXADC,SelSPI,WE_XADC, WE_SPI;
wire [31:0]XADC_in, SPI_in;
clk_wiz_0 U0
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
   // Clock in ports
    .clk_in1(clk));
mux2a1_32bits M0 (
.Entrada0({30'b0,0,OutSend}), .Entrada1({24'b0,cont_aux1[11:4]}),
.SEL(SelSPI),.Salida(SPI_in) 
);
/*mux2a1_32bits M1 (
.Entrada0({31'b0,OutNew}), .Entrada1(cont_aux2),
.SEL(SelXADC),.Salida(XADC_in) 
);*/
assign XADC_in ={16'b0,cont_aux2[11:4], 6'b0,OutFlag ,OutNew};
assign Flag=OutFlag;
wire EN2;
reg_aux_1 R1 (.Data_XADC(XADC_out), .WE_aux1(WE_aux1),.clk(clk_out1),.rst(rst), .cont_aux1(cont_aux1));
reg_aux_2 R0 (.Data_SPI(SPI_out), .WE_aux2(WE_aux2),.clk(clk_out1),.rst(rst), .cont_aux2(cont_aux2));
FSM_SICTAD C1 (.clk(clk_out1), .rst(rst), .new(XADC_out[0]), .send(SPI_out[0]), .Flag(XADC_out[1]),
            .EN(EN2),.SelXADC(SelXADC) ,.SelSPI(SelSPI) ,.WE_XADC(WE_XADC), .WE_SPI(WE_SPI), 
            .OutNew(OutNew), .OutSend(OutSend), .OutFlag(Flag),.WEaux1(WE_aux1),.WEaux2(WE_aux2));
XADCmodule S0 (.vauxn2(vauxn2),.vauxp2(vauxp2), .clk(clk_out1),.rst(rst),.Sel(SelXADC), .XADC_IN(XADC_in),
            .WE1(WE_XADC),.XADC_OUT(XADC_out));
SPImodule S1(.clkfast(clk_out1),.rst(rst),.MISO(MISO),.RegSel(SelSPI),.WR(WE_SPI),
                .DatosIN(SPI_in),
                .SalidaMUX(SPI_out), 
                .MOSI(MOSI),.SS(SS),.SCLK(SCLK));
Dispay_SICTAD D1 (.Data1(cont_aux1), .Data2(cont_aux2),
                    .Load(EN2),.clk(clk_out1), .rst(rst),.speed(2'b00),
                    .Anode_Control(an),.Cathode_Control(seg));

GPulso G1(.clk(clk_out1),.rst(~rst),.in(EN),.out(EN2));
endmodule 