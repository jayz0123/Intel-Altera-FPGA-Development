/* Receiver */
/* Error Detector Module */

/* This module get the data from the receiver
data register to decide whether there is a parity 
error or framing error. Odd parity is used for 
checking the parity error */

module ErrorDetectorRx
(
	data,
	parity_error,
	framing_error
);

input		[8:0]		data;			// 9 bits: 1 stop bit + 1 parity bit + 7 data bits

output 				parity_error;
output				framing_error;


// if the stop bit is not 1, it indicates that there is a framing error upon transmission
assign framing_error = (data[8] != 1'b1) ? 1'b1 : 1'b0;

/* if XOR the 8 bits (1 parity bit + 7 data bits) do not result a 1,
that means that the number of 1 in the data bits number is not odd number, 
which indicates that a parity error happens */
assign parity_error = (^data[7:0] != 1'b1) ? 1'b1 : 1'b0;
endmodule