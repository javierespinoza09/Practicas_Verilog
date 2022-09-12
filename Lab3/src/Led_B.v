module led_B (input [0:3] SW,
              output reg B);
always @ (*) begin
	case(SW)
    0: B=~1;
	1: B=~1;
	2: B=~1;
	3: B=~1;
	4: B=~1;
	5: B=~0;
	6: B=~0;
	7: B=~1;
	8: B=~1;
	9: B=~1;
	10: B=~1;
	11: B=~0;
	12: B=~0;
	13: B=~1;
	14: B=~0;
	15: B=~0;
	endcase
end            
endmodule