/* Generic Bit Counter Module */

/* The bit counter has a increment of 1 whenever it receives a
INC signal from the controller. If the counted bits reaches the
desired value, it outputs a bit done signal of 1 */

module BitCounter
(
	input 		clk,
	input 		rst,
	input			ena,
	input 		inc,
	output reg	bit_done
);

parameter BITNUM = 4'd10;

reg [3:0] pcount, ncount;

always @(posedge clk)
begin
	pcount <= ncount;
end

always @(rst, ena, pcount, inc)
begin
	bit_done = 1'b0; 
	ncount = pcount;
	
	if(!rst)
		ncount = 4'd0;
	else begin
		if(ena) begin
			if (pcount == BITNUM)
				bit_done = 1'b1;
				
			if (inc)
				if (pcount == BITNUM)
					ncount = 4'd0;
				else
					ncount = pcount + 4'd1;
		end
	end
end
endmodule	