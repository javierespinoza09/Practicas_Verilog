module DEMUX_WE_A (input SEL, input WE_procesador, 
                   output reg RAM_WE, WE_perif);
always @(*) begin
    RAM_WE=0;
    WE_perif=0;
    case (SEL)
        0:RAM_WE=WE_procesador;
        1:WE_perif=WE_procesador;
    endcase 
end
endmodule