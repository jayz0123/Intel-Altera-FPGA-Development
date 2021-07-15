/* Receiver */
/* 7 Segment Decoder Module */

/* 7 segnment decoder which decodes the
receiver data from the ASCII code to the
corresponding hexdecimal number and shows 
them on the 7 segment LED */

module SevenSegDecoder
(	
	input			[3:0]		data_decoding,			// decoding data: half part of ASCII code of 4 bits 
	output reg 	[6:0] 	data_decoded			// decoded data: 7 segment LED data: 7 bits
);

always @(data_decoding)
begin
	case(data_decoding)
		// 0 for turn on the LED of the 7 segment
		4'b0000:	data_decoded = 7'b1000000;		// 0
		4'b0001:	data_decoded = 7'b1111001;		// 1
		4'b0010:	data_decoded = 7'b0100100;		// 2
		4'b0011:	data_decoded = 7'b0110000;		// 3
		4'b0100:	data_decoded = 7'b0011001;		// 4
		4'b0101:	data_decoded = 7'b0010010;		// 5
		4'b0110:	data_decoded = 7'b0000010;		// 6
		4'b0111:	data_decoded = 7'b1111000;		// 7
		4'b1000:	data_decoded = 7'b0000000;		// 8
		4'b1001:	data_decoded = 7'b0010000;  	// 9
		4'b1010:	data_decoded = 7'b0001000;		// A
		4'b1011:	data_decoded = 7'b0000011;		// B
		4'b1100:	data_decoded = 7'b1000110;		// C
		4'b1101:	data_decoded = 7'b0100001;		// D
		4'b1110:	data_decoded = 7'b0000110; 	// E
		4'b1111:	data_decoded = 7'b0001110; 	// F
		default:	data_decoded = 7'b1111111;		// all lights turn off
	endcase
end
endmodule
