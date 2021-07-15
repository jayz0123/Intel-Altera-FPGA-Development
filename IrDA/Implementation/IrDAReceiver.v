module IrDAReceiver
(
	input				clk,
	input				rst,
	input				ena,
	input				start,
	input 			rxd_ir,
	output [6:0]	hex6,
	output [6:0] 	hex5,
	output			parity_error,
	output			framing_error,
	output			done
);

wire [9:0] data_rxd;
wire clear_baud;
wire clear_bit;
wire clear_shift;
wire bit_done;
wire shift;
wire inc;
wire baud_rxir;
wire ena_bit;
wire ena_baud;
wire ena_inv;
wire parity_bit;
wire txd;

ShiftRegister receiver_shift_register
(
	.clk(clk),
	.rst(!clear_shift),
	.shift(shift),
	.serial_in(rxd_ir),
	.parallel_out(data_rxd)
);

BaudGenerator receiver_baud_generator
(
	.clk(clk),
	.rst(!clear_baud),
	.ena(ena_baud),
	.baud_rxir(baud_rxir)
);

BitCounter receiver_bit_counter
(
	.clk(clk),
	.rst(!clear_bit),
	.ena(ena_bit),
	.inc(inc),
	.bit_done(bit_done)
);

ErrorDetector receiver_error_detector
(
	.data(data_rxd[9:1]),
	.parity_error(parity_error),
	.framing_error(framing_error)
);

SevenSegDecoder receiver_hex6_decoder
(
	.data_decoding({1'b0, data_rxd[7:5]}),		// a 0 is put in front to meet the ASCII table
	.data_decoded(hex6)
);

SevenSegDecoder receiver_hex5_decoder
(
	.data_decoding(data_rxd[4:1]),
	.data_decoded(hex5)
);

ReceiverController receiver_controller
(
	.clk(clk),
	.rst(rst),
	.ena(ena),
	.start(start),
	.bit_done(bit_done),
	.baud_rxir(baud_rxir),
	.shift(shift),
	.inc(inc),
	.ena_baud(ena_baud),
	.ena_bit(ena_bit),
	.clear_baud(clear_baud),
	.clear_bit(clear_bit),
	.clear_shift(clear_shift),
	.done(done)
);
endmodule
