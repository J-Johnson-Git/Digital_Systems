`timescale 1ns / 1ps

/*
	look at y pos, if within box_time, then decrement address
	on each line
*/

module addr_gen_combo
(
	input [9:0] y_pos,
	input [9:0] v_val,
	input [6:0] ascii_addr,  //desired ascii character
	output [10:0] addr  //concantonated ascii character address with counter value 
);

assign addr = (v_val == y_pos) ? {ascii_addr, 4'hF} :
			  (v_val == y_pos + 1 ) ? {ascii_addr, 4'hE} : 
			  (v_val == y_pos + 2 ) ? {ascii_addr, 4'hD} : 
			  (v_val == y_pos + 3 ) ? {ascii_addr, 4'hC} : 
			  (v_val == y_pos + 4 ) ? {ascii_addr, 4'hB} : 
			  (v_val == y_pos + 5 ) ? {ascii_addr, 4'hA} : 
			  (v_val == y_pos + 6 ) ? {ascii_addr, 4'h9} : 
			  (v_val == y_pos + 7 ) ? {ascii_addr, 4'h8} : 
			  (v_val == y_pos + 8 ) ? {ascii_addr, 4'h7} : 
			  (v_val == y_pos + 9 ) ? {ascii_addr, 4'h6} : 
			  (v_val == y_pos + 10) ? {ascii_addr, 4'h5} : 
			  (v_val == y_pos + 11) ? {ascii_addr, 4'h4} : 
			  (v_val == y_pos + 12) ? {ascii_addr, 4'h3} : 
			  (v_val == y_pos + 13) ? {ascii_addr, 4'h2} : 
			  (v_val == y_pos + 14) ? {ascii_addr, 4'h1} : 
			  (v_val == y_pos + 15) ? {ascii_addr, 4'h0} : 11'd0;
endmodule
