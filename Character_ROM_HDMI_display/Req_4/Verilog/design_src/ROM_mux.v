`timescale 1ns / 1ps

/*
	Mux that chooses from upper part of DO to lower part of DO based on counter for box_time
	sel needs to be driven from 0 - 1 when we are halfway through the box_time display area
	sel is driven by box_time_half
*/

module ROM_mux
(
	input sel,
	input [7:0] char_red,
	input [7:0] char_green,
	input [7:0] char_blue,
	output [7:0] red,
	output [7:0] green,
	output [7:0] blue
);

assign red = sel ? char_red : 8'd0;
assign green = sel ? char_green : 8'd0;
assign blue = sel ? char_blue : 8'd0;

endmodule
