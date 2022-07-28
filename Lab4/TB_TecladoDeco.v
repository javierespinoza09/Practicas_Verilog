`timescale 1ns / 1ps

module TB_TecladoDeco;

reg a, b, c, d;
wire [3:0] DecoOUT;

Teclado_Deco F1(
    .a(a), .b(b), .c(c), .d(d),  .Salida(DecoOUT)    
    );

initial begin 
    a = $random; b = $random; c = $random; d = $random;
    
    #10 begin a = $random; b = $random; c = $random; d = $random; end
    #10 begin a = $random; b = $random; c = $random; d = $random; end
    #10 begin a = $random; b = $random; c = $random; d = $random; end
    #10 begin a = $random; b = $random; c = $random; d = $random; end
    #10 begin a = $random; b = $random; c = $random; d = $random; end    
    #10 begin a = $random; b = $random; c = $random; d = $random; end
    #10 begin a = $random; b = $random; c = $random; d = $random; end
    #10 begin a = $random; b = $random; c = $random; d = $random; end
    
    #10 $finish;

end
endmodule