module RegistroTeclado(
    input WE_Procesador, WE_Teclado, CLK, RESET,
    input [31:0] IN,
    output [31:0] OUT
);
reg [31:0] OUT_0;
always @(posedge CLK)begin
    if(RESET) OUT_0<= 32'b0;
    else begin
        if(WE_Procesador) OUT_0 <= IN;
        else begin 
            if(WE_Teclado) OUT_0 <= {1'b1,IN[30:0]};
            else OUT_0 <= OUT_0;
        end    
    end
end
assign OUT=OUT_0;
endmodule