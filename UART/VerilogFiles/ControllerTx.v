/* Transmitter */
/* Controller Module */

/* Controller module for the transmitter
which has 4 state: IDLE, LOAD, TRANS, and HOLD,
which indicates, respectively, the transmitter is idle, 
the transmitter loads the data, the transmitter is 
transmitting  the data, the transmitter is preparing
for the next idle state. The controller output
relative signals to control the other module of the transmitter */

module ControllerTx
(
	clk,
	reset,
	start,
	bit_counter,
	load,
	baud_enable
);

parameter 			IDLE 	= 2'b00;	// idle state, where data is ready to be transmitted
parameter 			LOAD 	= 2'b01;	// load state, where data is loaded
parameter 			TRANS = 2'b10;	// transmitting state, where data is transmitted
parameter 			HOLD = 2'b11;	// hold state, hold for next transmit when the pushbutton is released

input 				clk;
input 				reset;
input 				start;			// connect to pushbutton to send data
input 	[3:0]		bit_counter;

output 				load;
output				baud_enable;

reg					load;				// load data to the shift register
reg					baud_enable;	// enable the baud generator	
reg		[1:0]		pstate;
reg		[1:0]		nstate;


// state machine
always @(posedge clk)
begin
	if(!reset)
		pstate <= IDLE;

	else
		pstate <= nstate;
end

always @(pstate, start, bit_counter)
begin
	nstate		= pstate;				// default keep the present state in loop
	
	load 			= 1'b0;					//	default for load disabled and baud generator disabled
	baud_enable = 1'b0;
	
	case(pstate)
		IDLE:
		begin
			if(!start)
				nstate 	= LOAD;			// start to transmit when pushbutton is pressed
		end
		
		LOAD:
		begin
			load 			= 1'b1;			// load the data to the shift register
			baud_enable = 1'b1;			// enable the baud generator

			nstate  		= TRANS;			// move to the TRANS state
		end
		
		TRANS:
		begin
			baud_enable = 1'b1;			// enable the baud generator
				
			if(bit_counter == 4'd11)	// when 11 bits of data is counted, that means 1 set of data is completed transmitting
				nstate 	= READY;			// move to the HOLD state
		end
		
		HOLD:
		begin
			if(start)
				nstate	= IDLE;			// move to the IDLE state when pushbutton is released
		end
		
		default
		begin
			nstate 		= IDLE;			// IDLE state by default
		end
	endcase
end
endmodule