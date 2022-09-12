module TOPSPI (
input clkfast,rst, start,MISO,clear,EN, VerCuenta,
input [7:0] DatosIN,
output [7:0] Anode_Control,
output [6:0] Cathode_Control,
output MOSI,SS,CLK,ready
);

wire clk;
  clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(clk),     // output clk_out1
   // Clock in ports
    .clk_in1(clkfast));      // input clk_in1   
wire [31:0] IN2Control, IN2Datos, OUTControl, OUTDatos, Salida;
reg [31:0] Entrada;
reg RegSel,WR;
wire WR2Datos,WR2Control,WR1Datos,WR1Control;

wire [31:0] SalidaMUX;
wire Salida0DEMUX, Salida1DEMUX;
wire StartP,clearP;



GPulso G1(.clk(clk),.rst(rst),.in(start),.out(StartP));
GPulso G2(.clk(clk),.rst(rst),.in(clear),.out(clearP));
control_reg C1(.clk(clk),.rst(rst),.IN1(Entrada),.IN2(IN2Control),.WR1(Salida0DEMUX),.WR2(WR2Control),.control_out(OUTControl));
datos_reg D1(.clk(clk),.rst(rst),.IN1(Entrada),.IN2(IN2Datos),.WR1(Salida1DEMUX),.WR2(WR2Datos),.datos_out(OUTDatos));

demux1a2 d1(.Entrada(WR),.SEL(RegSel),.Salida0(Salida0DEMUX),.Salida1(Salida1DEMUX));
mux2a1 m1(.Entrada0(OUTControl),.Entrada1(OUTDatos),.SEL(RegSel),.Salida(Salida));

ControlSPI S1(.rst(rst),.clk(clk),.CLK(CLK),.MOSI(MOSI),.MISO(MISO),.OUTControl(OUTControl),.OUTDatos(OUTDatos),.IN2Control(IN2Control),.IN2Datos(IN2Datos),.SS(SS),.WR2Control(WR2Control),.WR2Datos(WR2Datos));

Display D10(.Dis0(Salida[3:0]),.Dis1(Salida[7:4]),.Dis2(Salida[11:8]),.Dis3(Salida[15:12]),.Dis4(4'b0),.Dis5(4'b0),.Dis6(4'b0),.Dis7(4'b0),.clk(clk),.rst(rst),.Anode_Control(Anode_Control),.Cathode_Control(Cathode_Control));


//assign DatosOUT=Salida[15:0];
assign ready=~(OUTControl[0]|OUTControl[1]);

always @(posedge clk) begin
 if (StartP) begin
 Entrada={16'b0, OUTControl [15:8], 6'b0, 1'b0, 1'b1};
 RegSel=0;
 WR=1;
 end
 else if (clearP) begin
 Entrada={16'b0, OUTControl [15:8], 6'b0, 1'b1, 1'b0};
 RegSel=0;
 WR=1;
 end
 else if (EN) begin Entrada={ 20'b0, 4'b0, DatosIN [7:0]};
 RegSel=1;
 WR=1;
 end
 else if (VerCuenta) begin WR=0;RegSel=0; Entrada={ 20'b0, 4'b0, DatosIN [7:0]}; end
 else begin WR=0; RegSel=1; Entrada={ 20'b0, 4'b0, DatosIN [7:0]};  end

 end

endmodule