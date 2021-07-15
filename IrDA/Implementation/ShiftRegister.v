/* Generic Shift Register */

/* This shift register is used for both the transmitter
and the receiver since it conbines both the PISO and
SIPO functionality */

module ShiftRegister
(
	input				clk,
	input 			rst,
	input 			shift,				// signal to shift the data in the shift register
	input				load,					// signal to load the parallel data to the shift register
	input				serial_in,
	input		[9:0]	parallel_in,
	output			serial_out,
	output	[9:0]	parallel_out
);

parameter IDLEBITS = 10'b111_111_111_1;

reg [9:0] pdata, ndata;			// present data and next data

assign serial_out 	= pdata[0];
assign parallel_out 	= pdata;	 

always @(posedge clk)
begin
	pdata <= ndata;
end

always @(rst, pdata, shift, load, serial_in, parallel_in)
begin
	ndata = pdata;									// hold the data in the register
	
	if(!rst)
		ndata = IDLEBITS;							// reset the data as idle bits (i.e. logic 1) 
	else begin
		if(shift)
			ndata = {serial_in, pdata[9:1]};	//	shift the data by 1 bit, set the serial data input as the MSB
		else if(load)
			ndata = parallel_in;					// load the parallel data input
	end
end
endmodule
