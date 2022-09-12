module led_C (input [0:3] SW,
              output reg C);
always @ (*) begin
	case(SW)
    0: C=~1;
	1: C=~1;
	2: C=~0;
	3: C=~1;
	4: C=~1;
	5: C=~1;
	6: C=~1;
	7: C=~1;
	8: C=~1;
	9: C=~1;
	10: C=~1;
	11: C=~1;
	12: C=~0;
	13: C=~1;
	14: C=~0;
	15: C=~0;
	endcase
end            
endmodule