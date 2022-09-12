`timescale 1ns / 1ps


module SimulationRegister3();
    
reg CLK;
reg EN;
reg Reset;
reg SEND;
reg STOP;
reg CLEAR_NTX;

wire [31:0] RegistroControl;

RegistroControl3 F1(.CLK(CLK), .EN(EN), .RESET(Reset), .SEND(SEND), 
                    .STOP(STOP), .CLEAR_NTX(CLEAR_NTX),.REGISTRO_CONTROL(RegistroControl));

initial begin
    CLK = 1;
    forever #10 CLK = ~CLK;
end

initial begin
    EN = 1;
    Reset = 1;
    STOP = 0;
    SEND = 1;
    CLEAR_NTX = 0;
    
    #10 Reset = 0;
end

endmodule