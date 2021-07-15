/* Transmitter */
/* Bit Counter Module */

/* This module counts the data bits 
that have been transmitted and output the 
counting number to the transmitter controller to
detect whether the receiving process is completed. */

module BitCounterTx
(
	clk,
	clk_baud,
	reset,
	load,
	bit_counter
);

input					clk;
input					clk_baud;
input					reset;
input					load;

output 	[3:0]		bit_counter;

reg	 	[3:0]		bit_counter;


always @(posedge clk)
begin
	if(!reset)
		bit_counter <= 4'b0000;
		
	else if(load)
		// start from 0 when data is loaded
		bit_counter <= 4'b0000;
		
	else if(!load && clk_baud)
		// increment of 1 at every baud clock
		bit_counter <= bit_counter + 1'b1;
end
endmodule