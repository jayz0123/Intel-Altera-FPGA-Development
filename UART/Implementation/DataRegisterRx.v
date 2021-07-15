/* Receiver */
/* Data Register Module */

/* This module stores the received data
which comprises 9 bits that are necessary
to be handled: 1 stop bits + 1 parity bits
+ 7 data bits the 7 segment decoder and 
the error detector take the data stored in
this module to do some further operation */

module DataRegisterRx
(
	clk,
	reset,
	load,
	data_in,
	data_out
);

input					clk;
input 				reset;
input					load;
input  	[8:0] 	data_in;

output 	[8:0]		data_out;

reg	 	[8:0] 	data_out;


always @(posedge clk)
begin
	if(!reset)
		data_out <= 9'b11_1111111;
		
	else if(load)
		// when load signal is received from the controller, the module load the data from the shift register to 
		data_out <= data_in;
end
endmodule