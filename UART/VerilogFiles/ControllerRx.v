/* Receiver */
/* Controller Module */

/* Controller module for the receiver
which has 3 state: IDLE, RCV, and LOAD,
which indicates, respectively, the receiver 
is idle, the receiver is receiving the data, 
the receiver loads the data to the data register
for display. The controller output relative
signals to control the other module of the receiver */

module ControllerRx
(
	clk,
	reset,
	start,
	bit_counter,
	load,
	clear,
	baud_enable
);

parameter 			IDLE 	= 2'b00;			// idle state, data are ready to be received
parameter 			RCV	= 2'b01;			// receive state, data are on the progress of receiving
parameter 			LOAD 	= 2'b10;			// load state, data are loaded to the data register and displayed on the 7 segment led

input 				clk;
input 				reset;
input 				start;					// a start bit of 0 trigger the process of receving
input 	[3:0]		bit_counter;
	
output 				load;						// load the data to the data register
output				baud_enable;			// enable baud generator
output				clear;					// clear the bit counter

reg 					clear;
reg					load;
reg					baud_enable;
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
	
	load 			= 1'b0;
	baud_enable = 1'b0;
	clear 		= 1'b0;
	
	case(pstate)
		IDLE:
		begin
			clear 		= 1'b1;			// clear the bit counter for receiving 
			
			if(!start)
				nstate = RCV;				// move to RCV state for receiving data
		end
		
		RCV:
		begin
			baud_enable = 1'b1;			// enable the baud generator
			
			if(bit_counter == 4'd10)	// when 10 bits of data is received
				nstate = LOAD;
		end
		
		LOAD:
		begin
			load 			= 1'b1;			// load them into data register for display
			
			nstate 		= IDLE;			// back to IDLE state
		end
		
		default
		begin			
			nstate 		= IDLE;			// IDLE state by default
		end
	endcase
end
endmodule