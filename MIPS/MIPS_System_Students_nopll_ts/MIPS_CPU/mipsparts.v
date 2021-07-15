
module regfile(input         clk, 
               input         we, 
               input  [4:0]  ra1, ra2, wa, 
               input  [31:0] wd, 
               output [31:0] rd1, rd2);

  reg [31:0] rf[31:0];

  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clock
  // register 0 hardwired to 0

  always @(posedge clk)
    if (we) rf[wa] <= wd;	

  assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
  assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule


module alu(input      [31:0] a, b, 
           input      [3:0]  alucont, 
           output reg [31:0] result,
           output            zero);

  wire [31:0] a2, b2, sum, slt;
  
  assign a2 = alucont[3] ? ~a:a;
  assign b2 = alucont[2] ? ~b:b; 
  assign sum = a2 + b2 + alucont[3] + alucont[2];
  assign slt = sum[31];

  always@(*)
    case(alucont[1:0])
      2'b00: result <= a2 & b2;
      2'b01: result <= a2 | b2;
      2'b10: result <= sum;
      2'b11: result <= slt;
    endcase

  assign zero = (result == 32'b0);

endmodule


module adder(input [31:0] a, b,
             output [31:0] y);

  assign y = a + b;
endmodule



module sl2(input  [31:0] a,
           output [31:0] y);

  // shift left by 2
  assign y = {a[29:0], 2'b00};
endmodule



module sign_zero_ext(input      [15:0] a,
                     input             signext,
                     output reg [31:0] y);
              
   always @(*)
	begin
	   if (signext)  y <= {{16{a[15]}}, a[15:0]};
	   else          y <= {16'b0, a[15:0]};
	end

endmodule



module byte_addr(	input			[31:0] 	addr_in,
						input			 			loadbyte,
						output reg 	[31:0]	addr_out);
	always @(*)
	begin		
		if(loadbyte)
			addr_out <= {addr_in[31:2], 2'b00};
		else
			addr_out <= addr_in;
	end
				
endmodule



module word_to_byte(input		 [31:0] a,
						  input		 [1:0]  whichbyte,
						  input				  loadbyte,
						  output reg [31:0] y);
	
	always @(*)
	begin
		if(loadbyte)	
			case(whichbyte[1:0])
				2'b00: y <= {24'b0, a[7:0]};
				2'b01: y <= {24'b0, a[15:8]};
				2'b10: y <= {24'b0, a[23:16]};
				2'b11: y <= {24'b0, a[31:24]};
			endcase
		else				
			y <= a[31:0];
	end
	
endmodule



module shift_left_16(input      [31:0] a,
		               input         		shiftl16,
                     output reg [31:0] y);

   always @(*)
	begin
	   if (shiftl16) y = {a[15:0],16'b0};
	   else          y = a[31:0];
	end
              
endmodule



module flopr #(parameter WIDTH = 8)
              (input                  clk, reset,
               input      [WIDTH-1:0] d, 
               output reg [WIDTH-1:0] q);

  always @(posedge clk, posedge reset)
    if (reset) q <= 0;
    else       q <= d;

endmodule



module flopenr #(parameter WIDTH = 8)
                (input                  clk, reset,
                 input                  en,
                 input      [WIDTH-1:0] d, 
                 output reg [WIDTH-1:0] q);
 
  always @(posedge clk, posedge reset)
    if      (reset) q <= 0;
    else if (en)    q <= d;

endmodule



module mux2 #(parameter WIDTH = 8)
             (input  [WIDTH-1:0] d0, d1, 
              input              s, 
              output [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 

endmodule
