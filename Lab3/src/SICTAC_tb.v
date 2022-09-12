`timescale 1ns/1ps
module SICTAC_tb ();

wire MOSI,SS,SCLK,flag;
wire [6:0] seg;
wire [7:0] an;
reg clk, rst,EN,vauxn2,vauxp2,MISO;
SICTAD SIC1(.clk(clk),.rst(rst),.EN(EN),.vauxn2(0),.vauxp2(1), .MISO(MISO), .MOSI(MOSI),.SS(SS),.SCLK(SCLK),.Flag(flag),
                .seg(seg), .an(an));
                

initial begin

forever begin
#5
clk=~clk;
end

end

initial begin
clk=0;
rst=1;
EN=0;
MISO=1;
#2000

rst=0;
#2000
EN=1;
#20000






$finish;
end
endmodule