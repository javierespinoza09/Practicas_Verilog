module RegistroControl3(
    input CLK, EN, RESET, SEND, STOP, CLEAR_NTX,
    output [31:0] REGISTRO_CONTROL    
    );
    
    reg [31:0] REGISTRO_CONTROL3;
    reg [7:0] NUMERO_TRANSACCIONES;
    
   always @(posedge CLK)begin
        if(EN == 1) begin
            if(RESET == 1) REGISTRO_CONTROL3 <= 32'b0; //RESET ACTIVADO EN ALTO
            else begin
                if(CLEAR_NTX == 1) begin
                    NUMERO_TRANSACCIONES <= 8'b0;
                    REGISTRO_CONTROL3[1] <= 0;
                end
                else begin //CLEAR_NTX == 0
                    if(STOP == 1) begin
                        REGISTRO_CONTROL3[0] <= 0; //SE ASIGNA SEND A CERO
                    end
                    else begin //STOP == 0
                        if(SEND == 1) begin
                            REGISTRO_CONTROL3[0] <= 1; //SE ASIGNA SEND A 1
                            if(NUMERO_TRANSACCIONES != 8'b11111111) NUMERO_TRANSACCIONES = NUMERO_TRANSACCIONES + 1;
                            //Contador8Bits F2(.CLK(CLK), .EN(EN), .RESET(RESET),.RESULTADO(NUMERO_TRANSACCIONES));
                            REGISTRO_CONTROL3 [15:8] <= NUMERO_TRANSACCIONES [7:0];                     
                        end                    
                    end                    
                end
            end
        end
    
    
    end  
     
    assign REGISTRO_CONTROL = REGISTRO_CONTROL3;
     
endmodule