module led_A (input [0:3] SW,
              output reg A);
always @ (*) begin
	case(SW)
    0: A=~1;
	1: A=~0;
	2: A=~1;
	3: A=~1;
	4: A=~0;
	5: A=~1;
	6: A=~1;
	7: A=~1;
	8: A=~1;
	9: A=~1;
	10: A=~1;
	11: A=~0;
	12: A=~0;
	13: A=~0;
	14: A=~1;
	15: A=~1;
	endcase
end            
endmodule