module led_G (input [0:3] SW,
              output reg G);
always @ (*) begin
	case(SW)
    0: G=~0;
	1: G=~0;
	2: G=~1;
	3: G=~1;
	4: G=~1;
	5: G=~1;
	6: G=~1;
	7: G=~0;
	8: G=~1;
	9: G=~1;
	10: G=~1;
	11: G=~1;
	12: G=~1;
	13: G=~1;
	14: G=~1;
	15: G=~1;
	endcase
end            
endmodule