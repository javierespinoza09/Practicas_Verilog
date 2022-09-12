module MUX2_1(
    input SEL, CLK,
    input [31:0] VAR_A,
    input [31:0] VAR_B,
    output reg [31:0] RESULTADO
    );
    
    always @(VAR_A, VAR_B, SEL, posedge CLK)begin
        if(SEL==0)RESULTADO <= VAR_A;
        else RESULTADO <= VAR_B;   
    end
endmodule