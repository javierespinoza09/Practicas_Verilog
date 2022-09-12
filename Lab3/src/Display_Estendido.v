module Dispay_Extendido #(parameter ANCHO=4 )(input [(2**ANCHO)-1:0] Data,
                                       input Load0,Load1,
                                       input clk, rst,
                                       input [1:0]speed,
                                       output [7:0] Anode_Control,
                                       output [6:0] Cathode_Control);
    wire [3:0] BCD_IN0,BCD_IN1,BCD_IN2,BCD_IN3;
    wire clk_out1, EN,Reg_Sel;
    wire [2:0] SEL;
    wire [3:0] BCD_Decoder_In;
    wire [15:0] Reg_0,Reg_1;
    
    
    
    
 clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
   // Clock in ports
    .clk_in1(clk));
    WE_Regster U0 (.Data(Data),.rst(rst),.EN(Load0),.clk(clk_out1),.Reg_Out0(Reg_0));
    WE_Regster U1 (.Data(Data),.rst(rst),.EN(Load1),.clk(clk_out1),.Reg_Out0(Reg_1));
    clock_divider_reg U2  (.clk(clk_out1), .rst(rst), .clk_slow_reg(Reg_Sel), .speed(speed));
    Reg_Sel U3 (.Reg_0(Reg_0),.Reg_1(Reg_1), .SEL(Reg_Sel), .Salida_0(BCD_IN0),
                .Salida_1(BCD_IN1),.Salida_2(BCD_IN2),.Salida_3(BCD_IN3));
    Clock_Divider_Display U4 (.clk(clk_out1), .rst(rst), .clk_slow(EN));
    Counter_Refresh U5 (.clk(clk_out1), .EN(EN), .rst(rst), .Count_Out(SEL)); 
    BCD_Sel U6 (.SW0(BCD_IN0),.SW1(BCD_IN1),.SW2(BCD_IN2),.SW3(BCD_IN3),
                .SW4(Data[3:0]),.SW5(Data[7:4]),.SW6(Data[11:8]),.SW7(Data[15:12]),
                .SEL(SEL), .Salida(BCD_Decoder_In));
    BCD_Decoder U7 (.BCD_Decoder_In(BCD_Decoder_In), .BCD_Decoder_Out(Cathode_Control));
    Anode_Control U8 (.SEL(SEL), .Anode_Control_Out(Anode_Control));
                                             
endmodule 