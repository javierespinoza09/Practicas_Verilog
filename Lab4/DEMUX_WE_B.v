module DEMUX_WE_B (input [2:0]SEL, input WE_procesador, 
                   output reg WE_ADC_control, WE_Teclado, WE_siete_segmentos, WE_LEDs, 
                   WE_Switches, WE_Timer);
always @(*) begin
    WE_ADC_control=0;
    WE_Teclado=0;
    WE_siete_segmentos=0;
    WE_LEDs=0;
    WE_Switches=0;
    WE_Timer=0;
    case (SEL)
        0:WE_ADC_control=WE_procesador;
        2:WE_Teclado=WE_procesador;
        3:WE_siete_segmentos=WE_procesador;
        4:WE_LEDs=WE_procesador;
        5:WE_Switches=WE_procesador;
        6:WE_Timer=WE_procesador;
    endcase
end
endmodule