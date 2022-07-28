module XADC_control (input [7:0]umbral, input [11:0]Dato, input new,clk,rst, 
                    output reg [11:0]result, output reg WE2,rst_new,flag);
wire [11:0] umbral_control;
reg [1:0] estado;

assign umbral_control = {umbral,4'b0};
always @(posedge clk) 
    begin
        if (rst) estado <= 2'b00;
        else begin
            if (new) begin
                if (Dato>umbral_control) estado<=2'b10;
                else estado<=2'b01;
            end
            else begin
                estado <= 2'b00;
            end
        end
    end
always @(*) begin
    case (estado)
    0: begin
        result = Dato;
        WE2 = 1'b0;
        rst_new = 1'b1;
        flag = 1'b0;
    end
    1: begin
        result = Dato;
        WE2 = 1'b1;
        rst_new = 1'b0;
    end
    2:begin 
        result = Dato;
        WE2 = 1'b1;
        rst_new = 1'b0;
        flag = 1'b1;
    end
    3: begin
        result = Dato;
        WE2 = 1'b0;
        rst_new = 1'b1;
        flag = 1'b0;
    end
endcase
end 
endmodule