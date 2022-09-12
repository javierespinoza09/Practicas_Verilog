module Dispay_SICTAD #(parameter ANCHO=4 )(input [31:0] Data1,Data2,
                                       input Load,
                                       input clk, rst,
                                       input [1:0]speed,
                                       output [7:0] Anode_Control,
                                       output [6:0] Cathode_Control);
    wire [3:0] BCD_IN0,BCD_IN1,BCD_IN2,BCD_IN3,BCD_IN4,BCD_IN5,BCD_IN6,BCD_IN7;
    wire EN,Reg_Sel;
    wire [2:0] SEL;
    wire [3:0] BCD_Decoder_In;
    wire [31:0] Reg_0,Reg_1;
    
    
    WE_Regster U0 (.Data(Data1),.rst(rst),.EN(Load),.clk(clk),.Reg_Out0(Reg_0));
    WE_Regster U1 (.Data(Data2),.rst(rst),.EN(Load),.clk(clk),.Reg_Out0(Reg_1));
    clock_divider_reg U2  (.clk(clk), .rst(rst), .clk_slow_reg(Reg_Sel), .speed(speed));
    Reg_Sel_SICTAD U3 (.Reg_0(Reg_0),.Reg_1(Reg_1), .SEL(Reg_Sel), .Salida_0(BCD_IN0),
                .Salida_1(BCD_IN1),.Salida_2(BCD_IN2),.Salida_3(BCD_IN3));
    Clock_Divider_Display U4 (.clk(clk), .rst(rst), .clk_slow(EN));
    Counter_Refresh U5 (.clk(clk), .EN(EN), .rst(rst), .Count_Out(SEL)); 
    BCD_Sel U6 (.SW0(BCD_IN0),.SW1(BCD_IN1),.SW2(BCD_IN2),.SW3(BCD_IN3),
                .SW4(BCD_IN4),.SW5(BCD_IN5),.SW6(BCD_IN6),.SW7(BCD_IN7),
                .SEL(SEL), .Salida(BCD_Decoder_In));
    BCD_Decoder U7 (.BCD_Decoder_In(BCD_Decoder_In), .BCD_Decoder_Out(Cathode_Control));
    Anode_Control U8 (.SEL(SEL), .Anode_Control_Out(Anode_Control));
                                             
endmodule 