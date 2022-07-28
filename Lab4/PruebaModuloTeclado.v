module PruebaModuloTeclado(
    input clk, 
    input [4:0] JA, //PMOD HEADER
    input [1:0] Dis0, //SWITCHES
    output [8:0] led, //LED
    output [7:0] Anode_Control,
    output [6:0] Cathode_Control
);
wire CLK_10MHz;
wire [31:0] ProcesadorIN_Mux;
wire [31:0] Salida;

assign ProcesadorIN_Mux = 32'b0;

//Encendido de LEDS de prueba
assign led [0] = JA[0]; 
assign led [1] = JA[1]; 
assign led [2] = JA[2]; 
assign led [3] = JA[3]; 


clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(CLK_10MHz),     // output CLK_10MHz
   // Clock in ports
    .clk_in1(clk));

ModuloTeclado F1(
    .CLK(CLK_10MHz), .A(JA[3]), .B(JA[2]), .C(JA[1]), .D(JA[0]), .E(JA[4]), 
    .WE_Procesador(Dis0[1]), .RESET(Dis0[0]),
    .ProcesadorIN_Mux(ProcesadorIN_Mux),
    .OUT(Salida)
);

Display F2(.Dis0(Salida[3:0]), .Dis1(Salida[7:4]), .Dis2(Salida[11:8]), .Dis3(Salida[15:12]), .Dis4(Salida[19:16]), .Dis5(Salida[23:20]), .Dis6(Salida[27:24]), .Dis7(Salida[31:28]),
           .clk(clk), .rst(~Dis0[0]), .Anode_Control(Anode_Control), .Cathode_Control(Cathode_Control));

endmodule