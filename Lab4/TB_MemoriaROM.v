`timescale 1ns/1ps

module TB_MemoriaROM;
    wire [31:0]douta;
    reg [6:0] addra;
    reg clka;
    reg rsta;
    parameter AddressMAX = 16;

    Memoria_ROM U0(
    .douta(douta),
    .addra(addra),
    .clka(clka),
    .rsta(rsta)
    );

    always #50 clka=~clka;
    initial begin
        clka=0;
        rsta<=1;
        addra<=0;
        
        @(posedge clka);
        @(posedge clka);
         #10 rsta<=0;
        repeat (AddressMAX) begin
             @(posedge clka);
             #10 addra<=addra+1;
        end 
        
		@(posedge clka);
		@(posedge clka);
		$finish;
    end
endmodule 