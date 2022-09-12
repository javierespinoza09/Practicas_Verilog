`timescale 1ns / 1ps

module TBMUX2_1();

reg CLK;
reg SEL;
reg [31:0] VAR_A;
reg [31:0] VAR_B;

wire [31:0] RESULTADO;

MUX2_1 F1(.SEL(SEL), .CLK(CLK), .VAR_A(VAR_A), .VAR_B(VAR_B), .RESULTADO(RESULTADO));

initial begin
    CLK=0;
    forever #10 CLK=~CLK;
end

initial begin
    SEL=0;
    VAR_A = $random;
    VAR_B = $random;
    
    forever #10 SEL=~SEL;
end

endmodule
