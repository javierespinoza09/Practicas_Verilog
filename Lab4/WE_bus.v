module WE_bus (input WE_procesador, input [31:0] addrs, output RAM_WE,WE_ADC_control, WE_Teclado, WE_siete_segmentos, WE_LEDs, 
                   WE_Switches, WE_Timer);
wire WE_perif;
DEMUX_WE_A DEA (.SEL(addrs[8]), .WE_procesador(WE_procesador), 
               .RAM_WE(RAM_WE), .WE_perif(WE_perif));
DEMUX_WE_B DEB (.SEL(addrs[4:2]), .WE_procesador(WE_perif), 
                .WE_ADC_control(WE_ADC_control), .WE_Teclado(WE_Teclado), 
                .WE_siete_segmentos(WE_siete_segmentos), .WE_LEDs(WE_LEDs), 
                .WE_Switches(WE_Switches), .WE_Timer(WE_Timer));
endmodule