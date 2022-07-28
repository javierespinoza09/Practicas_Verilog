module led_F (input [0:3] SW,
              output reg F);
always @ (*) begin
	case(SW)
    0: F=~1;
	1: F=~0;
	2: F=~0;
	3: F=~0;
	4: F=~1;
	5: F=~1;
	6: F=~1;
	7: F=~0;
	8: F=~1;
	9: F=~1;
	10: F=~1;
	11: F=~1;
	12: F=~0;
	13: F=~0;
	14: F=~1;
	15: F=~1;
	endcase
end            
endmodule