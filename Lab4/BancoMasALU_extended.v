module BancoMasALU_extended #(parameter ANCHO=32,N=5)(
    input [31:0] PC,imm,Memoria,
    input [4:0]  rs1,rs2,rd,
    input [3:0]  SEL_OP,
    input [1:0]  Sel_Reg_In,
    input        srcB_SEL, srcA_SEL,RD_WE,rst,clk,
    
    output [31:0] address, data_out,
    output flagC,flagZ,flagError,flagNegativo
);

wire [31:0] A,B;
reg [31:0] data_in;

extended_ALU EA(.RS1_data(A), 
                .RS2_data(B),
                .imm(imm),.PC(PC), 
                .srcB_SEL(srcB_SEL), 
                .srcA_SEL(srcA_SEL),
                .SEL_OP(SEL_OP),  
                .Resultado(address), 
                .flagC(flagC),.flagZ(flagZ),.flagError(flagError),.flagNegativo(flagNegativo)
);
banco_reg br(.addr_rs1(rs1),
             .addr_rs2(rs2),
             .addr_rd(rd),
             .data_in(data_in),
             .clk(clk),.rst(rst),.we(RD_WE),
             .rs1(A),.rs2(B)
);

always @(*) begin
 case(Sel_Reg_In)
 0:data_in=address;
 1:data_in=imm;
 2:data_in=Memoria;
 3:data_in=PC;
 endcase
end
assign data_out = B;
endmodule 