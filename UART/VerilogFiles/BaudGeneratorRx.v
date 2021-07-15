/* Receiver */
/* Baud Generator Module */

/* This module generator a baud clock
which is based on the given baud rate
and the system clock which is 50MHz.
For the receiver, the baud clock is 
necessary to be delay for a half period*/

module BaudGeneratorRx
#(
	BAUDRATE
)
(
	clk,
	reset,
	baud_enable,
	clk_baud
);

input					clk;
input					reset;
input 				baud_enable;

output				clk_baud;

// counter that counts up to 2^11 = 2048 because we need 1302 as the max number
reg		[10:0]	counter;

initial
begin
	counter = 11'b0;
end

always @(posedge clk)
begin
	if(!reset)
		counter <= 11'b0;
	
	else if(baud_enable)
		// count up to max when enabled
		counter <= (counter == BAUDRATE - 1'b1) ? 1'b0 : counter + 1'b1;
	
	else
		// counter start at half to delay the baud clock for a half period
		counter <= (BAUDRATE - 1'b1) / 2'd2;
end

assign clk_baud = !counter && baud_enable;
endmodule
