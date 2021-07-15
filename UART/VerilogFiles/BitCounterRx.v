/* Receiver */
/* Bit Counter Module */

/* This module counts the data bits 
that have been received and output the 
counting number to the receiver controller to
detect whether the receiving process is completed. */

module BitCounterRx
(
	clk,
	clk_baud,
	reset,
	clear,
	bit_counter
);

input					clk;
input					clk_baud;
input					reset;
input					clear;
	
output	[3:0]		bit_counter;

reg	 	[3:0]		bit_counter;


always @(posedge clk)
begin	
	if(!reset)
		bit_counter <= 4'b0000;
		
	else if(clear)
		// reset the bit counter when it receives a clear signal
		bit_counter <= 4'b0000;
		
	else if(!clear && clk_baud)
		// increment of 1 at every baud clock
		bit_counter <= bit_counter + 1'b1;
end
endmodule