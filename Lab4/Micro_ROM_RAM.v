module Micro_ROM_RAM (input clk, rst,
                      input [4:0]JB,
                      input [15:0]sw,
                      /*output [31:0]direccion, Imm, Read_Data_o,Instr,*/
                      /*output [8:0]P_Addrs,*/
                      output [15:0] led,
                      
                      output [7:0] Anode_Control,
                      output [6:0] Cathode_Control);
wire [31:0]addrs,data_out,Read_Data,ADC_read, Teclado,
           siete_segmentos, LEDs, Switches, Timer;
wire [8:0]Prog_Addrs;
wire NOT_rst;
wire [31:0]Instruction;
wire WE,clk_out1;
wire [1:0]PC_Ctrl;
wire [31:0] Immmm;
wire RAM_WE,WE_ADC_control,WE_Teclado,WE_siete_segmentos,WE_LEDs,WE_Switches,WE_Timer;
wire [31:0] Memory_in;
assign NOT_rst=~rst;
clk_wiz_0 CW0
   (
    // Clock out ports
    .clk_out1(clk_out1),     // output clk_out1
   // Clock in ports
    .clk_in1(clk));      // input clk_in1*/
Datapath D1 (.Instruction(Instruction), .Read_Data(Memory_in),
          .rst(rst), .clk(clk_out1),
          .WE(WE)/*Este no es el WE final*/, 
          .addrs(addrs),.data_out(data_out), .Prog_Addrs(Prog_Addrs), 
          .PC_Ctrl(PC_Ctrl),.Immmm(Immmm));
 
Memoria_ROM ROM(
    .douta(Instruction), //32 bits
    .addra(Prog_Addrs), //64 instrucciones
    .clka(clk_out1),
    .rsta(NOT_rst)
    );
    
WE_bus WEbus (.WE_procesador(WE), .addrs(addrs), .RAM_WE(RAM_WE),.WE_ADC_control(WE_ADC_control),
        .WE_Teclado(WE_Teclado), .WE_siete_segmentos(WE_siete_segmentos), .WE_LEDs(WE_LEDs), 
        .WE_Switches(WE_Switches), .WE_Timer(WE_Timer));
        
read_bus readbus (.addrs(addrs), .data_RAM(Read_Data), .ADC_control(ADC_read), 
                  .ADC_data(ADC_read), .Teclado(Teclado),
                  .siete_segmentos(siete_segmentos), .LEDs(LEDs), .Switches(Switches), 
                  .Timer(Timer),
                  .Memory_in(Memory_in));
                  
reg_WE_32bits R0 (.Data_in(data_out), .clk(clk_out1),.rst(rst), .WE(WE_ADC_control),
                  .Data_o(ADC_read));
/*reg_WE_32bits R1 (.Data_in(data_out), .clk(clk_out1),.rst(rst), .WE(WE_Teclado),
                  .Data_o(Teclado));*/
               
/*XADCmodule PERIF01(.vauxn2(vauxn2),.vauxp2(vauxp2), .clk(clk),.rst(rst),.Sel(addrs[2]), 
                   .XADC_IN(data_out),.WE1(WE_ADC_control),.XADC_OUT(ADC_read));*/

ModuloTeclado PERIF2 (
    .CLK(clk_out1), .A(JB[3]), .B(JB[2]), .C(JB[1]), .D(JB[0]), .E(JB[4]), .WE_Procesador(WE_Teclado), .RESET(rst),
    .ProcesadorIN_Mux(data_out),
    .OUT(Teclado));
               
Display_Interface PERIF3 (.BCD_Data(data_out),.Display_WE(WE_siete_segmentos), .clk(clk_out1), .rst(rst),
                   .Anode_Control(Anode_Control),
                   .Cathode_Control(Cathode_Control),
                   .Display_Data(siete_segmentos));
BloqueLEDs (
 .Entrada(data_out), 
 .WE(WE_LEDs),.rst(rst),.clk(clk_out1),
 .Salida(LEDs),
 .led(led)
 
);
BloqueSwitches (
.Entrada(data_out),
.WE(WE_Switches),.rst(rst),.clk(clk_out1),
.Salida(Switches),
.sw(sw)
);

BloqueTimer (
    .rst(rst),.clk(clk_out1),.WE(WE_Timer),
    .Entrada(data_out),
    .Salida(Timer)
);
    
Memoria_RAM RAM(
    .douta(Read_Data),
    .dina(data_out),
    .addra(addrs[7:2]),
    .clka(clk_out1),
    .rsta(NOT_rst),
    .wea(RAM_WE)
);

/*assign direccion=addrs;
assign Imm=Immmm;
assign Read_Data_o=Read_Data;
assign Instr=Instruction;
assign P_Addrs=Prog_Addrs;*/
endmodule