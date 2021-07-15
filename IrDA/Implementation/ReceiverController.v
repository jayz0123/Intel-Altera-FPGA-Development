/* Receiver */
/* Controller Module */

/* Controller module for the receiver
which has 3 state: IDLE, RCV, and LOAD,
which indicates, respectively, the receiver 
is idle, the receiver is receiving the data, 
the receiver loads the data to the data register
for display. The controller output relative
signals to control the other module of the receiver */
module ReceiverController
(
	input			clk,
	input			rst,
	input			ena,
	input			start,
	input			bit_done,
	input			baud_rxir,
	output reg	shift,		// shift the shift register
	output reg	inc,			// increment the bit counter
	output reg	ena_baud,	// enable the baud generator
	output reg 	ena_bit,		// enable the bit counter
	output reg  clear_baud,
	output reg	clear_bit,
	output reg	clear_shift,
	output reg	done
);

parameter IDLE = 2'b00;		// idle state, data are ready to be received
parameter RCV	= 2'b01;		// receive state, data are on the progress of receiving
//parameter LOAD	= 2'b11;		// load state, data are displayed on the 7 segment led

reg [1:0] pstate, nstate;

always @(posedge clk)
begin
	pstate <= nstate;
end

always @(pstate, rst, ena, start, bit_done, baud_rxir)
begin
	shift				= 1'b0;
	inc				= 1'b0;
	ena_baud			= 1'b0;
	ena_bit 			= 1'b0;
	clear_baud		= 1'b0;
	clear_bit		= 1'b0;
	clear_shift		= 1'b0;
	done				= 1'b0;
	nstate 			= pstate;		// default keep the present state in loop
	
	if(!rst) begin
		clear_baud		= 1'b1;
		clear_bit		= 1'b1;
		clear_shift		= 1'b1;
		nstate 			= IDLE;
	end
	else if(ena) begin
		case(pstate)
			IDLE: begin
				clear_baud	= 1'b1;
				clear_bit	= 1'b1;
			
				if(start)
					nstate = RCV;				// start to transmit when pushbutton is pressed
			end

			RCV: begin
				ena_baud	= 1'b1;				// enable the baud generator
				ena_bit  = 1'b1;				// enable the bit counter
				
				if(bit_done) begin			// when 10 bits of data is counted, a frame of data is completed receiving
					done 		= 1'b1;
					nstate 	= IDLE;			// move to the IDLE state
				end
				
				if(baud_rxir) begin			// shift and increment every baud tick
					shift = 1'b1;
					inc 	= 1'b1;
				end	
			end
			
			default begin
				nstate = IDLE;					// IDLE state by default
			end
		endcase
	end
end
endmodule
