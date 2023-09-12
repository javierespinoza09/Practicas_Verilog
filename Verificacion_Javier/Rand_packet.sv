class Packet;
	rand bit [2:0] header;
	bit encode;
	rand bit [2:0] mode;
	rand bit [7:0] data;
	bit stop;

	function new ();
                this.encode = 0;
                this.stop = 1;
        endfunction


	constraint c_header {header >= 1; header <= 5;}
	constraint c_mode {mode == 4;}
	constraint c_data {data <= 12; data > 2;}

	function display ();
		$display("header = 0x%0h, encode = %0b, mode = 0x%0h, stop = %0b, data = 0x%0h",
		  this.header,this.encode,this.mode,this.stop, this.data);
	endfunction
endclass
