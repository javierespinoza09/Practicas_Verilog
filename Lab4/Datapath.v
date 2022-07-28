module Datapath (input [31:0]Instruction, Read_Data,
                 input rst, clk,
                 output WE, output [31:0]addrs,data_out, output[8:0]Prog_Addrs, 
                 output [1:0] PC_Ctrl,output [31:0] Immmm);
wire [3:0] ALU_OP;
wire zero, lt, RD_WE, imm_extend_WE, SrcA_SEL, SrcB_SEL, fetch;
wire [6:0]OPC,Func7;
wire [1:0] Sel_Reg_In, PC_Control;
wire [2:0] imm_SEL,func3;
wire [31:0] jump_dir,imm, current_PC, PC_link;
wire [4:0] rs1,rs2,rd;
wire [3:0]  SEL_OP;
wire NOT_rst;
wire [31:0]address;
assign NOT_rst=~rst;
assign jump_dir=address;
assign addrs=address;
assign PC_Ctrl = PC_Control;
assign Immmm=imm;
Control_Unit CU (.rst(rst),.clk(clk),.zero(zero),.lt(lt), .OPC(OPC), .Func3(func3), .Func7(Func7),
              .ALU_OP(ALU_OP), 
              .SrcB_SEL(SrcB_SEL), .SrcA_SEL(SrcA_SEL),.fetch(fetch), .Sel_Reg_In(Sel_Reg_In), .PC_Control(PC_Control), 
              .imm_SEL(imm_SEL), 
              .RD_WE(RD_WE), .WE(WE), .imm_extend_WE(imm_extend_WE));
PC PC1(.clk(clk), .rst(rst),.SEL(PC_Control),
    .jump_dir(jump_dir),
    .PC_out(current_PC),
    .PC_inc(PC_link));
BancoMasALU_extended Mod1 (
    .PC(current_PC),.imm(imm),.Memoria(Read_Data),
    .rs1(rs1),.rs2(rs2),.rd(rd),
    .SEL_OP(ALU_OP),
    .Sel_Reg_In(Sel_Reg_In),
    .srcB_SEL(SrcB_SEL), .srcA_SEL(SrcA_SEL),.RD_WE(RD_WE),.rst(rst),.clk(clk),
    .address(address), .data_out(data_out),
    .flagC(),.flagZ(zero),.flagError(),.flagNegativo(lt)
);
Instruction_handler Mod2 (.clk(clk),.rst(rst), .fetch(fetch), .imm_extend_WE(imm_extend_WE),
                          .imm_SEL(imm_SEL), 
                          .in_instruction(Instruction),
                          .RS1(rs1),.RS2(rs2),.RD(rd),
                          .imm_out(imm),
                          .OPC(OPC), .func7(Func7), 
                          .func3(func3));
assign Prog_Addrs = current_PC[10:2];
                 
endmodule