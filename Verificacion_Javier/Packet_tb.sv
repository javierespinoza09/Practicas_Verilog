`include "Packet_class.sv"

module Packet_tb;
	Packet pkg1, pkg2;
	initial begin 
		pkg1 = new (3'h2,2'h3);
		pkg1.display();
	end
endmodule

