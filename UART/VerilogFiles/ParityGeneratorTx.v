/* Transmitter */
/* Parity Generator Module */

/* This module generate a parity bit
according to the given data bits. Odd
parity is followed */

module ParityGeneratorTx
(
	data,
	parity_bit
);

input 	[6:0]		data;

output 				parity_bit;

/* if XOR the data bits result a 1, it means the total
number of 1 in data bits is odd, thus the parity bit is
0; if XOR the data bits result a 0, it means the total
number of 1 in data bits is even, thus the parity bit is 1 */
assign parity_bit = !(^data);	
endmodule