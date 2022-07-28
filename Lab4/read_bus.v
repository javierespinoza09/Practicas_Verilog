module read_bus (input [31:0] addrs, input [31:0] data_RAM, ADC_control, ADC_data, Teclado,
                 siete_segmentos, LEDs, Switches, Timer,
                 output [31:0]Memory_in);
wire [31:0] data_perif;
read_MUX_B B (.SEL(addrs[4:2]), 
            .ADC_control(ADC_control), .ADC_data(ADC_data), .Teclado(Teclado), 
            .siete_segmentos(siete_segmentos), .LEDs(LEDs), .Switches(Switches), .Timer(Timer),
            .read_data(data_perif));
read_MUX_A A (.addres8(addrs[8]),.data_RAM(data_RAM),.data_perif(data_perif), 
            .read_data(Memory_in));         
endmodule