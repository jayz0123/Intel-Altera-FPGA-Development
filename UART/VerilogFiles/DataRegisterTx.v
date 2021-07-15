/* Transmitter */
/* Data Register Module */

/* This module stores the trasmitting data
which comprises 7 bits that are necessary
to be handled: 7 data bits. The shift register
can load the data from this module to shift to
the tx output */

module DataRegisterTx
(
	clk,
	reset,
	data_in,
	data_out
);

input					clk;
input 				reset;
input 	[7:0] 	data_in;

output	[7:0]		data_out;

reg		[7:0] 	data_out;


initial
begin
	data_out = 8'b1_1111111;
end

always @(posedge clk)
begin
	if(!reset)
		data_out <= 8'b1_1111111;
		
	else
		data_out <= data_in;
end
endmodule