`timescale 1ns / 1ps

/*
	Creates a pulse that is asserted when the VGA controller is inside 
	valid display 16 X 16 box for a character to be put on screen
	
	x_pos ~ h_val
	y_pos ~ v_val
*/

module pulse_indicator
(
	input [9:0] h_val,
	input [9:0] v_val,
	input [9:0] x_pos,
	input [9:0] y_pos,
	output box_time
);

//defines a 16 x 16 box for displaying ROM data 
assign box_time = ((h_val >= x_pos) && (h_val < (x_pos + 10'd16)) && (v_val >= y_pos) && (v_val < (y_pos + 10'd16)));

endmodule
