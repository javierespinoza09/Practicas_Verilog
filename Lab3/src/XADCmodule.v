module XADCmodule (input vauxn2,vauxp2, input clk,rst,Sel, input [31:0] XADC_IN,input WE1,output [31:0] XADC_OUT);
wire enable,WE2;
wire [15:0] do_out;
wire [1:0] control_int;
wire [31:0] reg_control_out;
wire [31:0] data_reg_out;
wire [11:0] result;
wire [31:0] demux_out0,demux_out1;

xadc_wiz_0 U1 (
  .di_in(0),              // input wire [15 : 0] di_in
  .daddr_in(7'h12),        // input wire [6 : 0] daddr_in
  .den_in(enable),            // input wire den_in
  .dwe_in(0),            // input wire dwe_in
  .drdy_out(drdy_out),        // output wire drdy_out
  .do_out(do_out),            // output wire [15 : 0] do_out
  .dclk_in(clk),          // input wire dclk_in
  .vp_in(vp_in),              // input wire vp_in
  .vn_in(vn_in),              // input wire vn_in
  .vauxp2(vauxp2),            // input wire vauxp2
  .vauxn2(vauxn2),            // input wire vauxn2
  .channel_out(),  // output wire [4 : 0] channel_out
  .eoc_out(enable),          // output wire eoc_out
  .alarm_out(),      // output wire alarm_out
  .eos_out(),          // output wire eos_out
  .busy_out()        // output wire busy_out
);
mux2a1_32bits m32(
.Entrada0(reg_control_out), .Entrada1(data_reg_out),
.SEL(Sel),
.Salida(XADC_OUT) 
);
control_reg_XADC cx(.control_ext(XADC_IN),.control_int(control_int), 
                  .clk(clk),.rst(rst),.WE1(WE1),.WE2(WE2),
                  .control_out(reg_control_out));
data_reg_XADC dx(.data(result), .WE2(WE2),
               .clk(clk),.rst(rst),.data_reg_out(data_reg_out));
XADC_control xd(.umbral(reg_control_out[15:8]), .Dato(do_out[15:4]),
              .new(reg_control_out[0]),.clk(clk),.rst(rst),.result(result), 
              .WE2(WE2),.rst_new(control_int[0]),.flag(control_int[1]));
              
endmodule