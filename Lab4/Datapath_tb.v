`timescale 1ns/1ps
module Datapath_tb ;
wire [31:0]addrs,data_out;
wire [8:0]Prog_Addrs;
reg rst,NOT_rst,clk;
wire [31:0]Instruction;
wire WE;
wire [1:0]PC_Ctrl;
wire [31:0] Immmm;

Datapath U0 (.Instruction(Instruction), .Read_Data(),
          .rst(rst), .clk(clk),
          .WE(WE), .addrs(addrs), .Prog_Addrs(Prog_Addrs), .data_out(data_out),
          .PC_Ctrl(PC_Ctrl),.Immmm(Immmm));
Memoria_ROM MEM(
    .douta(Instruction), //32 bits
    .addra(Prog_Addrs), //64 instrucciones
    .clka(clk),
    .rsta(NOT_rst)
    );
initial begin
rst = 1;
NOT_rst = 0;
clk=0;


forever begin
    #5
    clk=~clk;
end

end
initial begin
repeat (20) begin
@(posedge clk);
end
#20
rst = 0;
NOT_rst = 1;
end
endmodule