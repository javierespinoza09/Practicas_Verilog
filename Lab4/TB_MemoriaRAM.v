`timescale 1ns/1ps

module TB_MemoriaRAM;
    integer i=0; 
    integer g=0;
    wire [31:0]doutaR;
    reg [31:0]dinaR;
    reg [31*(2**8):0]dinaR_prueba;
    reg [5:0] addraR;
    reg weaR;
    reg clka;
    reg rsta;
    parameter AddressMax = 63;
    
    Memoria_RAM U1(
    .douta(doutaR),
    .dina(dinaR),
    .addra(addraR),
    .clka(clka),
    .rsta(rsta),
    .wea(weaR)
    );
    
    always #5 clka=~clka;
    
    initial begin
        clka=0;
        rsta<=1;        
        addraR<=6'h00;
        dinaR<=0;
        weaR<=0;
        dinaR_prueba<=0;
        @(posedge clka);
        @(posedge clka);
         #10 rsta<=0;
        @(posedge clka);
        #10 weaR<=1;
	    addraR<=6'h00;
	    repeat (AddressMax) begin
            @(posedge clka);
            dinaR<=g;
            dinaR_prueba[i*32+:32]=dinaR; 
		    addraR<=addraR+1;
		    i<=i+1;
		    g<=g+1;
        end 
        @(posedge clka);
        weaR<=0;
        addraR<=32'h00;
        i<=0;
		repeat (AddressMax) begin
            @(posedge clka);
            if(doutaR==dinaR_prueba[i*32+:32])$display("Oks");
            else $display("Error");
		    addraR<=addraR+1;
		    i<=i+1;
        end 
        @(posedge clka);
        #10 addraR<=32'h00;
		@(posedge clka);
		@(posedge clka);
		$finish;
    end
    
endmodule 