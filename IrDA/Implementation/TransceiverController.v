module TransceiverController
(	
	input 		clk,
	input			rst,
	input			send_key,
	input			start_bit,
	input			trans_done,
	input			rcv_done,
	output reg	ena_trans,
	output reg	ena_rcv,
	output reg 	start_trans,
	output reg	start_rcv,
	output reg 	rst_transmitter,
	output reg	rst_receiver
);

parameter IDLE 	= 2'b00;
parameter TRANS	= 2'b01;
parameter RCV		= 2'b11;

reg [1:0] pstate, nstate;

always @(posedge clk)
begin
	pstate <= nstate;
end

always @(pstate, rst, send_key, start_bit, trans_done, rcv_done)
begin
	ena_trans			= 1'b0;
	ena_rcv				= 1'b0;
	start_trans			= 1'b0;
	start_rcv			= 1'b0;
	rst_transmitter	= 1'b0;
	rst_receiver 		= 1'b0;
	nstate 				= pstate;
	
	if(!rst) begin
		rst_transmitter	= 1'b1;
		rst_receiver		= 1'b1;
		nstate				= IDLE;
	end
	else begin
		case(pstate)
			IDLE: begin
				if(send_key == 0) begin
					ena_trans	= 1'b1;
					start_trans	= 1'b1;
					nstate 		= TRANS;
				end
				else if(start_bit == 0) begin
					ena_rcv		= 1'b1;
					start_rcv 	= 1'b1;
					nstate		= RCV;
				end
			end
			
			TRANS: begin
				ena_trans = 1'b1;
				
				if(trans_done)
					nstate = IDLE;
			end
			
			RCV: begin
				ena_rcv = 1'b1;
				
				if(rcv_done)
					nstate = IDLE;
			end
			
			default: begin
				nstate = IDLE;
			end
		endcase
	end
end
endmodule
