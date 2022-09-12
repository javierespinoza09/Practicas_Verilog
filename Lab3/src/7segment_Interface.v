module Interface #(parameter ANCHO=4 )(input [(2**ANCHO)-1:0] Data,
                                       input Load,
                                       input clk, rst,
                                       output [7:0] Anode_Control,
                                       output [6:0] Cathode_Control);
    wire [3:0] BCD_IN0,BCD_IN1,BCD_IN2,BCD_IN3;
    wire clk_out1, EN;
    wire [2:0] SEL;
    wire [3:0] BCD_Decoder_In;
    
    
    
    
 /*clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
   // Clock in ports
    .clk_in1(clk));*/
    
    WE_Regster U0 (.Data(Data),.rst(rst),.EN(Load),.clk(clk),.Reg_Out0(BCD_IN0),.Reg_Out1(BCD_IN1),.Reg_Out2(BCD_IN2),.Reg_Out3(BCD_IN3));
    Clock_Divider_Display U1 (.clk(clk), .rst(rst), .clk_slow(EN));
    Counter_Refresh U2 (.clk(clk), .EN(EN), .rst(rst), .Count_Out(SEL)); 
    BCD_Sel U3 (.SW0(BCD_IN0),.SW1(BCD_IN1),.SW2(BCD_IN2),.SW3(BCD_IN3),
                .SW4(Data[3:0]),.SW5(Data[7:4]),.SW6(Data[11:8]),.SW7(Data[15:12]),
                .SEL(SEL), .Salida(BCD_Decoder_In));
    BCD_Decoder U4 (.BCD_Decoder_In(BCD_Decoder_In), .BCD_Decoder_Out(Cathode_Control));
    Anode_Control U5 (.SEL(SEL), .Anode_Control_Out(Anode_Control));
                                             
endmodule 