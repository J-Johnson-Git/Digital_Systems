`timescale 1ns / 1ps

/*
	At each new pixel, look at the individual bits of the ROM data
	and display one 
*/

module ROM_reader
(
	input [9:0] x_pos,
	input [9:0] h_val,
	input [15:0] ROM,
	output ROM_MSB_bit
);

assign ROM_MSB_bit = (h_val == x_pos) ? ROM[15] :
					 (h_val == x_pos + 1 ) ? ROM[14] : 
					 (h_val == x_pos + 2 ) ? ROM[13] : 
					 (h_val == x_pos + 3 ) ? ROM[12] : 
					 (h_val == x_pos + 4 ) ? ROM[11] : 
					 (h_val == x_pos + 5 ) ? ROM[10] : 
					 (h_val == x_pos + 6 ) ? ROM[9] : 
					 (h_val == x_pos + 7 ) ? ROM[8] : 
					 (h_val == x_pos + 8 ) ? ROM[7] : 
					 (h_val == x_pos + 9 ) ? ROM[6] : 
					 (h_val == x_pos + 10) ? ROM[5] : 
					 (h_val == x_pos + 11) ? ROM[4] : 
					 (h_val == x_pos + 12) ? ROM[3] : 
					 (h_val == x_pos + 13) ? ROM[2] :  
					 (h_val == x_pos + 14) ? ROM[1] : 
					 (h_val == x_pos + 15) ? ROM[0] : 1'd0;

endmodule