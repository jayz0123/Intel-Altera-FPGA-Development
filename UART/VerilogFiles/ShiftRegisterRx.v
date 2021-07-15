/* Receiver */
/* SIPO Shift Register Module */

/* A Serial In Parallel Out shift register which
take a serial of data bits from rx and shift them
into the register. Once all the data are received,
they will be output at once. */

module ShiftRegisterRx
(
	clk,
	clk_baud,
	reset,
	serial_in,
	parallel_out
);

input					clk;
input 				clk_baud;
input 				reset;
input					serial_in;

output	[9:0]		parallel_out;

reg		[9:0]		data;


// fill the register with all 1s
initial
begin
	data = 10'b11_1111111_1;
end

always @(posedge clk)
begin
	if(!reset)
		data <= 10'b11_1111111_1;
		
	else if(clk_baud)
		// shift the data to right
		data <= {serial_in, data[9:1]};
end

// assign the output as the total set of data bits
assign parallel_out = data;
endmodule