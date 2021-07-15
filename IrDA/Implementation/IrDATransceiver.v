module IrDATransceiver
(	
	//output	trans_done,
	//output	rcv_done,
	//output	start_rcv,
	//output	start_trans,
	//output	rst_transmitter,
	//output	rst_receiver,
	//output	ena_trans,
	//output	ena_rcv,
	input				clk,
	input 			rst,
	input 	[6:0]	data_txd,
	input 			rxd_ir,
	input				send_key,
	output 	[6:0]	hex6,
	output	[6:0]	hex5,
	output			txd_ir,
	output			parity_error,
	output			framing_error
);

wire rst_transmitter;
wire rst_receiver;
wire ena_trans;
wire ena_rcv;
wire start_trans;
wire start_rcv;
wire trans_done;
wire rcv_done;

IrDATransmitter IrDA_transmitter
(
	.clk(clk),
	.rst(!rst_transmitter),
	.ena(ena_trans),
	.start(start_trans),
	.data_txd(data_txd),
	.txd_ir(txd_ir),
	.done(trans_done)
);

IrDAReceiver IrDA_receiver
(
	.clk(clk),
	.rst(!rst_receiver),
	.ena(ena_rcv),
	.start(start_rcv),
	.rxd_ir(rxd_ir),
	.hex6(hex6),
	.hex5(hex5),
	.parity_error(parity_error),
	.framing_error(framing_error),
	.done(rcv_done)
);

TransceiverController transceiver_controller
(
	.clk(clk),
	.rst(rst),
	.send_key(send_key),
	.start_bit(rxd_ir),
	.trans_done(trans_done),
	.rcv_done(rcv_done),
	.ena_trans(ena_trans),
	.ena_rcv(ena_rcv),
	.start_trans(start_trans),
	.start_rcv(start_rcv),
	.rst_transmitter(rst_transmitter),
	.rst_receiver(rst_receiver)
);
endmodule
