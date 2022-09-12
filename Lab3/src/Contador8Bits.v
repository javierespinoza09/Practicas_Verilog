module Contador8Bits(
    input CLK, EN, RESET,
    output reg [7:0] RESULTADO
    );
    
    always @(posedge CLK)begin
        if(EN == 1)begin
            if(RESET == 1) RESULTADO = 8'b0; //Reset activado en alto
            else begin
                if(RESULTADO != 8'b11111111) RESULTADO = RESULTADO + 1;
            end
        end
    end
endmodule