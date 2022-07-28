module Gen_Pulso(
input KEY, CLK, RESET,
output SALIDA);
//output CLK3,CLK4);

wire CLK2, Slow_CLK;
wire Q1,Q2,Q2_bar,Q0;

/*clk_wiz_0 instance_name
   (
    // Clock out ports
    .clk_out1(CLK2),     // output clk_out1
   // Clock in ports
    .clk_in1(CLK));      // input clk_in1*/

//assign CLK3 = CLK2;

ClockDivider F2(.clock_in(CLK), .clock_out(Slow_CLK));

//assign  CLK4 = Slow_CLK;

FlipFlipD F3(.CLK(CLK), .D(KEY), .CLK_EN(Slow_CLK), .Q(Q0));
FlipFlipD F4(.CLK(CLK), .D(Q0), .CLK_EN(Slow_CLK), .Q(Q1));
FlipFlipD F5(.CLK(CLK), .D(Q1), .CLK_EN(Slow_CLK), .Q(Q2));

assign Q2_bar = ~Q2;
assign SALIDA = Q1 & Q2_bar;

endmodule