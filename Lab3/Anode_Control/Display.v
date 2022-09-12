module Display #(parameter ANCHO=4)(input [ANCHO-1:0] Dis0,Dis1,Dis2,Dis3,Dis4,Dis5,Dis6,Dis7,
                                    input clk, rst,
                                    output [7:0] Anode_Control,
                                    output [6:0] Cathode_Control);
    wire rstNot,EN;
    wire [2:0] SEL;
    wire [3:0] BCD_Decoder_In;
    assign rstNot=~rst;

    Clock_Divider_Display U1 (.clk(clk), .rst(rstNot), .clk_slow(EN));
    Counter_Refresh U2 (.clk(clk), .EN(EN), .rst(rstNot), .Count_Out(SEL)); 
    BCD_Sel U3 (.SW0(Dis0),.SW1(Dis1),.SW2(Dis2),.SW3(Dis3),
                .SW4(Dis4),.SW5(Dis5),.SW6(Dis6),.SW7(Dis7),
                .SEL(SEL), .Salida(BCD_Decoder_In));
    BCD_Decoder U4 (.BCD_Decoder_In(BCD_Decoder_In), .BCD_Decoder_Out(Cathode_Control));
    Anode_Control U5 (.SEL(SEL), .Anode_Control_Out(Anode_Control));

endmodule