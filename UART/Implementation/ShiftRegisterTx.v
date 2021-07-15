/* Transmitter */
/* PISO Shift Register Module */

/* A Parallel In Serial Out shift register which
take a parallel of data bits from tx and shift them
out to the next module The data will be shifted one
by one. */

module ShiftRegisterTx
(
	clk,
	clk_baud,
	reset,
	load,
	parallel_in,
	serial_out
);

input					clk;
input 				clk_baud;
input 				reset;
input					load;				// the load signal which make the shift register load the data inside
input		[9:0]		parallel_in;

output 				serial_out;		// output data 1 by 1

reg		[9:0]		data;


always @(posedge clk)
begin
	if(!reset)
		data <= 10'b11_1111111_1;
		
	else if(load)
		// load the data from the input
		data <= parallel_in;
		
	else if(clk_baud)
		// shift the data to right at each baud clock
		data <= {1'b1, data[9:1]};
end

//	assign the output as the LSB of the data
assign serial_out = data[0];
endmodule