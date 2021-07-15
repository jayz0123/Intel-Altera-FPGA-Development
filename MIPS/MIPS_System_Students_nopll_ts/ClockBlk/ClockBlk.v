module ClockBlk (input inclk0, output reg c0, c1, c2, output locked);

reg [1:0] cnt;
assign locked = 1'b1;

always @ (posedge inclk0)
		case (cnt)
			2'b00: begin
					cnt <= 2'b01;
					c0 <= 1'b1;
					c1 <= 1'b0;
					c2 <= 1'b0;
				end
			2'b01: begin
					cnt <= 2'b10;
					c0 <= 1'b1;
					c1 <= 1'b1;
					c2 <= 1'b0;
				end
			2'b10: begin
					cnt <= 2'b11;
					c0 <= 1'b0;
					c1 <= 1'b1;
					c2 <= 1'b1;
				end
			2'b11: begin
					cnt <= 2'b00;
					c0 <= 1'b0;
					c1 <= 1'b0;
					c2 <= 1'b1;
				end			
			default: begin
					cnt <= 2'b00;
					c0 <= 1'b0;
					c1 <= 1'b0;
					c2 <= 1'b0;
				end
		endcase
endmodule
