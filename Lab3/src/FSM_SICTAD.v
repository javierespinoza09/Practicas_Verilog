module FSM_SICTAD (input clk, rst, new, send, Flag, EN,
                   output reg SelXADC ,SelSPI ,WE_XADC, WE_SPI, 
                              OutNew, OutSend, OutFlag,WEaux1,WEaux2
                   );
reg [2:0] estado_FSM;
always @(posedge clk) begin
    if (rst) estado_FSM <= 3'b0;
    else begin
        case (estado_FSM)
            0: estado_FSM <= estado_FSM+1;
            1: begin 
                if (new==0)estado_FSM <= estado_FSM+1;
                else estado_FSM <= estado_FSM;
            end
            2: estado_FSM <= estado_FSM+1;
            3: estado_FSM <= estado_FSM+1;
            4: estado_FSM <= estado_FSM+1;
            5: begin 
                if (send==0) estado_FSM <= estado_FSM+1;
                else estado_FSM <= estado_FSM;
            end
            6: begin
                if (EN) estado_FSM <= 0;
                else estado_FSM <= estado_FSM;
            end
            7: estado_FSM <= 0;
        endcase
    end
end
always @(*)begin
case (estado_FSM)
    0:begin
        SelXADC=0;SelSPI=0;WE_XADC=1;WE_SPI=0;OutNew=1;OutSend=1;OutFlag=0;WEaux1=0;WEaux2=0;
    end
    1:begin
        SelXADC=0;SelSPI=0;WE_XADC=0;WE_SPI=0;OutNew=1;OutSend=1;OutFlag=0;WEaux1=0;WEaux2=0;
    end
    2:begin
        SelXADC=1;SelSPI=0;WE_XADC=0;WE_SPI=0;OutNew=1;OutSend=1;OutFlag=0;WEaux1=1;WEaux2=0;
        if (Flag) OutFlag=1;
    end
    3:begin
        SelXADC=0;SelSPI=1;WE_XADC=0;WE_SPI=1;OutNew=1;OutSend=1;OutFlag=0;WEaux1=0;WEaux2=0;
    end
    4:begin
        SelXADC=0;SelSPI=0;WE_XADC=0;WE_SPI=1;OutNew=1;OutSend=1;OutFlag=0;WEaux1=0;WEaux2=0;
    end
    5:begin
        SelXADC=0;SelSPI=0;WE_XADC=0;WE_SPI=0;OutNew=1;OutSend=1;OutFlag=0;WEaux1=0;WEaux2=0;
    end
    6:begin
        SelXADC=0;SelSPI=1;WE_XADC=0;WE_SPI=0;OutNew=1;OutSend=1;OutFlag=0;WEaux1=0;WEaux2=1;
    end
    7:begin
        SelXADC=0;SelSPI=0;WE_XADC=0;WE_SPI=0;OutNew=1;OutSend=1;OutFlag=0;WEaux1=0;WEaux2=0;
    end
endcase
end
endmodule