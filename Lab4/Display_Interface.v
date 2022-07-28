module Display_Interface (input [31:0] BCD_Data,input Display_WE, clk, rst,
                          output [7:0] Anode_Control,
                          output [6:0] Cathode_Control,
                          output [31:0] Display_Data);
wire [31:0] Data_o;
reg_WE_32bits R0 (.Data_in(BCD_Data), .clk(clk),.rst(rst), .WE(Display_WE),
                  .Data_o(Data_o));
Display D0 (.Dis0(Data_o[3:0]),.Dis1(Data_o[7:4]),.Dis2(Data_o[11:8]),.Dis3(Data_o[15:12]),
         .Dis4(Data_o[19:16]),.Dis5(Data_o[23:20]),.Dis6(Data_o[27:24]),.Dis7(Data_o[31:28]),
         .clk(clk), .rst(rst),
         .Anode_Control(Anode_Control),
         .Cathode_Control(Cathode_Control));
assign Display_Data=Data_o;
endmodule