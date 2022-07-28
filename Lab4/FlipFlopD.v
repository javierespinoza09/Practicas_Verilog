module FlipFlipD(
    input CLK, D, CLK_EN,
    output reg Q =0
    );
    
    always @ (posedge CLK) begin
        if(CLK_EN == 1) Q <= D;
    end
endmodule