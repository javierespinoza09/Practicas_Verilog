module read_MUX_B (input [2:0]SEL, 
                   input [31:0] ADC_control, ADC_data, Teclado, siete_segmentos, LEDs, Switches, Timer,
                   output reg [31:0]read_data); //La selección depende de los bits [4:2] de la dirección
always @(*) begin
    case (SEL) 
        0:read_data=ADC_control;
        1:read_data=ADC_data;
        2:read_data=Teclado;
        3:read_data=siete_segmentos;
        4:read_data=LEDs;
        5:read_data=Switches;
        6:read_data=Timer;
        7:read_data=32'b0;
    endcase
end
                   
endmodule