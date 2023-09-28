class Packet;
	bit [2:0] header;
	bit encode;
	bit [2:0] mode;
	bit [7:0] data;
	bit stop;

	function new (bit [2:0] header = 3'h1, bit [2:0] mode = 5);
		this.header = header;
		this.encode = 0;
		this.mode = mode;
		this.stop = 1;
	endfunction

	function display ();
		$display("header = 0x%0h, encode = %0b, mode = 0x%0h, stop = %0b",
			  this.header,this.encode,this.mode,this.stop);
	endfunction
endclass
