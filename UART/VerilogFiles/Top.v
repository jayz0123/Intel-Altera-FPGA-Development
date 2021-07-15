/* Top Module */

/* All interconnection of modules are shown
in this Verilog file. */

module Top
(
	clk,							// input
	reset,						// input
	send_tx,						// input
	data_in_tx,					// input
	data_hex6,					// output
	data_hex5,					// output
	parity_error,				// output	
	framing_error,				// output
	tx,							// output
	rx								// input
);


parameter 			BAUDRATE = 11'd1302;	// set the baudrate to 50MHz / 38400 = 1302

input 				clk;						// 50MHz system clock
input 				reset;					// reset all states
input 				send_tx;					// a send command signal generated from a pushbutton
input					rx;						// rx signal as a input of data
input 	[6:0]	 	data_in_tx;				// the input data bits generated from 7 switches

output 				tx;						// serial output to the terminal computer 	
output	[6:0]		data_hex6;				// 7 segment to display the first hex number
output	[6:0]		data_hex5;				// 7 segment to display the second hex number
output				parity_error;			// output signal to control the parity error LED
output 				framing_error;			// output signal to control the framing error LED		

wire 					clk_baud_tx;			// baud clock generated for the transmitter
wire					clk_baud_rx;			// baud clock generated for the receiver
wire 					load_tx;					// load signal for shift register of transmitter
wire 					load_rx;					// load signal for data register of receiver
wire 					baud_enable_tx;		// enable signal for baud generator of transmitter
wire					baud_enable_rx;		// enable signal for baud generator of receiver
wire 		[7:0]		data_tx;					// transmitting data: 7 data bits + 1 parity bit
wire  	[9:0]		data_rx;					// receiving data: 1 start bit + 7 data bits + 1 parity bit + 1 stop bit
wire 		[3:0]		bit_counter_tx;		// bit counting signal for transmitter
wire 		[3:0]		bit_counter_rx;		// bit counting signal for receiver
wire					parity_bit_tx;			// generated parity bit for transmitter
wire					clear_rx;				// clear signal for the bit counter of receiver
wire		[8:0]		data_out_rx;			// parallel output data for receiver: 7 data bits + 1 parity bit + 1 stop bit


// transmitter baud generator
BaudGeneratorTx #(.BAUDRATE(BAUDRATE)) BGTx
(
	.clk(clk),
	.reset(reset),
	.baud_enable(baud_enable_tx),
	.clk_baud(clk_baud_tx)
);

// receiver baud generator
BaudGeneratorRx #(.BAUDRATE(BAUDRATE)) BGRx
(
	.clk(clk),
	.reset(reset),
	.baud_enable(baud_enable_rx),
	.clk_baud(clk_baud_rx)
);

// transmitter data register
DataRegisterTx DRTx
(
	.clk(clk),
	.reset(reset),
	.data_in({parity_bit_tx, data_in_tx}),
	.data_out(data_tx)
);

// receiver data register
DataRegisterRx DRRx
(
	.clk(clk),
	.reset(reset),
	.load(load_rx),
	.data_in(data_rx[9:1]), 			// storing the received data, but throwing the start bit
	.data_out(data_out_rx)
);

// transmitter shift register
ShiftRegisterTx SRTx
(
	.clk(clk),
	.clk_baud(clk_baud_tx),
	.reset(reset),
	.load(load_tx),
	.parallel_in({data_tx, 2'b01}), 	// the two less significant bits are 0 - start bit, 1 - bit to represent the IDLE state
	.serial_out(tx)
);

// receiver shift register
ShiftRegisterRx SRRx
(
	.clk(clk),
	.clk_baud(clk_baud_rx),
	.reset(reset),
	.serial_in(rx),
	.parallel_out(data_rx)
);

// transmitter bit counter
BitCounterTx BCTx
(
	.clk(clk),
	.clk_baud(clk_baud_tx),
	.reset(reset),
	.load(load_tx),
	.bit_counter(bit_counter_tx)
);

// receiver bit counter
BitCounterRx BCRx
(
	.clk(clk),
	.clk_baud(clk_baud_rx),
	.reset(reset),
	.clear(clear_rx),
	.bit_counter(bit_counter_rx)
);

// 7 segment decoder for hex6
Decoder7SegmentRx D7SHex6
(	
	.data_decoding({1'b0, data_out_rx[6:4]}),		// a 0 is put in front to meet the ASCII table
	.data_decoded(data_hex6)
);

// 7 segment decoder for hex5
Decoder7SegmentRx D7SHex5
(
	.data_decoding(data_out_rx[3:0]),
	.data_decoded(data_hex5)
);

// transmitter controller
ControllerTx CTx
(
	.clk(clk),
	.reset(reset),
	.start(send_tx),
	.bit_counter(bit_counter_tx),
	.load(load_tx),
	.baud_enable(baud_enable_tx)
);

// receiver controller
ControllerRx CRx
(
	.clk(clk),
	.reset(reset),
	.start(rx),
	.bit_counter(bit_counter_rx),
	.load(load_rx),
	.clear(clear_rx),
	.baud_enable(baud_enable_rx)
);

// parity bit generator for the transmitting data
ParityGeneratorTx PGTx
(
	.data(data_in_tx),
	.parity_bit(parity_bit_tx)
);

// framing and parity bit detector for the receiving data
ErrorDetectorRx EDRx
(
	.data(data_out_rx),
	.parity_error(parity_error),
	.framing_error(framing_error)
);
endmodule