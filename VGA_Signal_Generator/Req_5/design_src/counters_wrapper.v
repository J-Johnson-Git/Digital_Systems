`timescale 1ns / 1ps

/*
	Basic VGA controller, Project 1, Requirement 5.
	Displays crosshair
*/

module VGA_sync  
(
	input clk,
	input rst,
	output HS,
	output VS,
	output [3:0] red,
	output [3:0] green,
	output [3:0] blue
);

//video_active wire
wire video_active;

//hold values from counters so we can assign sync signals
wire [9:0] h_val;
wire [9:0] v_val;

//enables for each counter
wire h_en;
wire v_en;

//wizard clock output and reset output
wire wiz_locked;
wire pix_clk;

//color wires
wire [3:0] red;
wire [3:0] green;
wire [3:0] blue;

//25Mhz clk signal for counters
clk_wiz_0 clk_wizard
(
	.clk_out1(pix_clk),  //25Mhz Pixel clock 
	.reset(rst),  // Status and control signals
	.locked(wiz_locked),
	.clk_in1(clk)  // Clock in ports
);

//horizontal counter
param_counter # (.WIDTH(10), .MAX_VAL(798)) 
horizontal_counter
(
	.clk(pix_clk),
	.rst(rst),
	.en(h_en), 
	.count(h_val)
);

//vertical counter 
param_counter # (.WIDTH(10), .MAX_VAL(523))  
vertical_counter
(
	.clk(pix_clk),
	.rst(rst),
	.en(v_en), 
	.count(v_val)
);

//horizontal_counter always enabled
assign h_en = 1'b1; 

//enable vertical_counter when horizontal_counter hits MAX_VAL
assign v_en = (h_val == 10'd798) ? 1'd1 : 1'd0;  

//assert HS and VS during sync times
assign HS = (h_val < 10'd96) ? 1'd1 : 1'd0;
assign VS = (v_val < 10'd2) ? 1'd1 : 1'd0;
assign video_active = ((h_val < 10'd784) && (h_val > 10'd143) && (v_val < 10'd515) && (v_val > 10'd34));

//asserting RGB signals white during video_active time, driving them to ground outside video_active
assign red = (video_active && (h_val == 463)) ? 4'b1111 : 4'b0000;
assign green = (video_active && (v_val == 274)) ? 4'b1111 : 4'b0000;
assign blue = video_active ? 4'b0000 : 4'b0000;

endmodule
