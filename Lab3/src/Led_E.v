module led_E (input [0:3] SW,
              output reg E);
always @ (*) begin
	case(SW)
    0: E=~1;
	1: E=~0;
	2: E=~1;
	3: E=~0;
	4: E=~0;
	5: E=~0;
	6: E=~1;
	7: E=~0;
	8: E=~1;
	9: E=~0;
	10: E=~1;
	11: E=~1;
	12: E=~1;
	13: E=~1;
	14: E=~1;
	15: E=~1;
	endcase
end            
endmodule