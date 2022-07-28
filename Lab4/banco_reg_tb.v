`timescale 1ns/1ps
module banco_reg_tb #(parameter ANCHO=32,N=5);

reg [ANCHO-1:0] data_in;
reg [N-1:0] addr_rs1,addr_rs2,addr_rd;
reg clk,rst,we;

reg [(2**N)*ANCHO-1:0] Datos;

wire  [ANCHO-1:0] rs1,rs2;

banco_reg DUT(.data_in(data_in),.clk(clk),.rst(rst),.addr_rd(addr_rd),.addr_rs1(addr_rs1),.addr_rs2(addr_rs2),.rs1(rs1),.rs2(rs2),.we(we));


initial begin
Datos=0;
clk=0;
rst=0; 


forever begin
	#5
	clk=~clk;
end

end

integer i;
initial begin
data_in=0;
    addr_rd=0;
    
    
    addr_rs1=0;
    addr_rs2=0;
we=0;
i=0;
repeat (20) begin
@(posedge clk)#2;
end
rst=1; #1
i=0;
we=1;


@(posedge clk) #3
repeat (2**N+25) begin
    @(posedge clk)
    //data_in=$urandom%(2**ANCHO);
    data_in=2**i;
    addr_rd=i;
    
    
    addr_rs1=$urandom%N;
    addr_rs2=$urandom%N;
    
    @(posedge clk) #6;
    if (i<2**N) begin  Datos [i*ANCHO+:ANCHO]=data_in;  end
     
    if (Datos[addr_rs1*ANCHO+:ANCHO]!==rs1) $display("No se guardó el dato correcto %h es diferente de %h",Datos [addr_rs1*ANCHO+:ANCHO],rs1 );
    else $display("PASS");
    if (Datos[addr_rs2*ANCHO+:ANCHO]!==rs2) $display("No se guardó el dato correcto %h es diferente de %h",Datos [addr_rs2*ANCHO+:ANCHO],rs2 );
    else $display("PASS");
    i=i+1;
    if (i==2**N) we=0;
    #1;
end
/*
repeat (15) begin
    @(posedge clk) @(negedge clk)
    data_in=$urandom%(2**ANCHO);
    addr_rd=$urandom%N;
    addr_rs1=$urandom%N;
    addr_rs2=$urandom%N;
    we=1;
end
*/

#15
$finish;
end

endmodule