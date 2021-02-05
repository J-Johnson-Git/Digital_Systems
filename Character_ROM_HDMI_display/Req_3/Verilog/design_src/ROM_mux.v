`timescale 1ns / 1ps

/*
	Mux that chooses from upper part of DO to lower part of DO based on counter for box_time
	sel needs to be driven from 0 - 1 when we are halfway through the box_time display area
	sel is driven by box_time_half
*/

module ROM_mux
(
	input sel,
	output [7:0] color
);

assign color = sel ? 8'd255 : 8'd0;

endmodule
