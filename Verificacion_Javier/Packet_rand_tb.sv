`include "Rand_packet.sv"

module Packet_tb;
	Packet pkg1, pkg2;
	initial begin
	       	pkg1 = new;	
		for (int i = 0; i < 15; i++) begin
			pkg1.randomize;
			pkg1.display();
		end
	end
endmodule

