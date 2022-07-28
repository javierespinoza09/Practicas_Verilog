`timescale 1ns/1ps
module Control_Unit_tb;
reg clk,rst,zero,lt;
reg [6:0]OPC,Func7;
reg [2:0]Func3;
wire [3:0] ALU_OP;
wire SrcB_SEL, SrcA_SEL,fetch;
wire [1:0] Sel_Reg_In, PC_Control; 
wire [2:0] imm_SEL; 
wire RD_WE, WE, imm_extend_WE;


Control_Unit CU (.rst(rst),.clk(clk),.zero(zero),.lt(lt), .OPC(OPC), .Func3(Func3), .Func7(Func7),
              .ALU_OP(ALU_OP), 
              .SrcB_SEL(SrcB_SEL), .SrcA_SEL(SrcA_SEL),.fetch(fetch), .Sel_Reg_In(Sel_Reg_In), .PC_Control(PC_Control), 
              .imm_SEL(imm_SEL), 
              .RD_WE(RD_WE), .WE(WE), .imm_extend_WE(imm_extend_WE));
initial begin
rst=1;
clk=0;
zero=0;
lt=0;
OPC=0;
Func7=0;
Func3=0;
    forever begin
    #5
    clk=~clk;
    end
end
initial begin
#60
rst=0;
OPC=7'b0110011;
Func7=0;
Func3=0;
end
endmodule