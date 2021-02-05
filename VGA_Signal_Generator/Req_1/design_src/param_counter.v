`timescale 1ns / 1ps

/*
	Parameterized binary counter with width and max value params. Rolls over to zero when max value hit
*/

module param_counter # (parameter WIDTH = 4, parameter MAX_VAL = 3)
(
	input clk,
	input rst,
	input en,
	output reg [(WIDTH - 1):0] count = 0
);

always @ (posedge(clk))
begin
	if (rst) 
		count <= 0;
	else if (en)
		if (count == MAX_VAL)
			count <= 0;
		else
			count <= count + 1'd1;
	else
		count <= count;
end

endmodule
