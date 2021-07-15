module IrDATransmitter
(
	input			clk,
	input			rst,
	input			ena,
	input			start,
	input [6:0] data_txd,
	output		txd_ir,
	output		done
);

wire clear_baud;
wire clear_bit;
wire clear_shift;
wire clear_inv;
wire bit_done;
wire shift;
wire inc;
wire baud_full;
wire baud_txir;
wire ena_bit;
wire ena_baud;
wire ena_inv;
wire load;
wire parity_bit;
wire txd;


ShiftRegister transmitter_shift_register
(
	.clk(clk),
	.rst(!clear_shift),
	.shift(shift),
	.load(load),
	.serial_in(1'b1),
	.parallel_in({1'b1, parity_bit, data_txd, 1'b0}),
	.serial_out(txd)
);

BaudGenerator transmitter_baud_generator
(
	.clk(clk),
	.rst(!clear_baud),
	.ena(ena_baud),
	.baud_full(baud_full),
	.baud_txir(baud_txir)
);

BitCounter transmitter_bit_counter
(
	.clk(clk),
	.rst(!clear_bit),
	.ena(ena_bit),
	.inc(inc),
	.bit_done(bit_done)
);

ParityGenerator transmitter_parity_generator
(
	.data(data_txd),
	.parity_bit(parity_bit)
);

Inverter transmitter_inverter
(
	.clk(clk),
	.rst(!clear_inv),
	.ena(ena_inv),
	.txd(txd),
	.txd_ir(txd_ir)
);

TransmitterController transmitter_controller
(
	.clk(clk),
	.rst(rst),
	.ena(ena),
	.start(start),
	.bit_done(bit_done),
	.baud_full(baud_full),
	.baud_txir(baud_txir),
	.shift(shift),
	.load(load),
	.inc(inc),
	.ena_baud(ena_baud),
	.ena_bit(ena_bit),
	.ena_inv(ena_inv),
	.clear_baud(clear_baud),
	.clear_bit(clear_bit),
	.clear_shift(clear_shift),
	.clear_inv(clear_inv),
	.done(done)
);
endmodule
