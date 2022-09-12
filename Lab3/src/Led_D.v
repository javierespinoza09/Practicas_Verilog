module led_D (input [0:3] SW,
              output reg D);
always @ (*) begin
	case(SW)
    0: D=~1;
	1: D=~0;
	2: D=~1;
	3: D=~1;
	4: D=~0;
	5: D=~1;
	6: D=~1;
	7: D=~0;
	8: D=~1;
	9: D=~0;
	10: D=~0;
	11: D=~1;
	12: D=~1;
	13: D=~1;
	14: D=~1;
	15: D=~0;
	endcase
end            
endmodule