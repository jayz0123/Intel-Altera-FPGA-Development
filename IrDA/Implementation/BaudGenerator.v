/* Generic Baud Generator Module */

/* This module generator a tick every differnt number of system clocks */

module BaudGenerator
(
	input 		clk,
	input 		rst,
	input 		ena,
	output reg	baud_full,
	output reg 	baud_txir,
	output reg  baud_rxir
);

parameter 	BAUD38400 			= 5'd15;
parameter	SEVEN_SIXTEENTH 	= 5'd6;
parameter	TEN_SIXTEENTH		= 5'd9;
parameter	HALF_PERIOD			= 5'd4;

reg [4:0] pcount, ncount;

//parameter BAUD38400 			= 11'd1302;
//parameter SEVEN_SIXTEENTH 	= 11'd570;
//parameter TEN_SIXTEENTH		= 11'd814;
//parameter HALF_PERIOD		= 11'd60;

// counter that counts up to 2^11 = 2048 because we need 1302 as the max number
//reg [10:0] pcount, ncount;

always @(posedge clk)
begin
	pcount <= ncount;
end

always @(rst, pcount, ena)
begin
	baud_full 	= 1'b0;
	baud_txir 	= 1'b0;
	baud_rxir	= 1'b0;
	ncount 		= pcount;
	
	if(!rst)
		ncount = 11'd0;
	else begin
		if(pcount == BAUD38400)
			baud_full = 1'b1;
			
		if(pcount > SEVEN_SIXTEENTH && pcount <= TEN_SIXTEENTH)
			baud_txir = 1'b1;
		
		if(pcount == HALF_PERIOD)
			baud_rxir = 1'b1;
			
		if(ena) begin
			if(pcount == BAUD38400)
				ncount = 11'd0;
			else
				ncount = pcount + 11'd1;
		end
	end
end
endmodule
