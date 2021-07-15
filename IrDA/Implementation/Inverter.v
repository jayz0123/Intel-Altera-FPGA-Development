module Inverter
(
	input		clk,
	input		rst,
	input		ena,
	input 	txd,
	output	txd_ir
);

reg pval, nval;

assign txd_ir = pval;

always @(posedge clk)
begin
	pval <= nval;
end

always @(rst, pval, ena, txd)
begin
	nval = 1'b0;
	
	if(!rst)
		nval = 1'b0;
	else if(ena)
		if(txd == 1'b0)
			nval = 1'b1;
end
endmodule
