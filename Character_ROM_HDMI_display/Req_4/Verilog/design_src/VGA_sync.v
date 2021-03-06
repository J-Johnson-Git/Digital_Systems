`timescale 1ns / 1ps

/*
	Basic VGA controller
*/

module VGA_sync  
(
	input pix_clk,
	input rst,
	input box_time,
	input [7:0] back_red,
	input [7:0] back_green,
	input [7:0] back_blue,
	input [7:0] char_red,
	input [7:0] char_green,
	input [7:0] char_blue,
	output HS,
	output VS,
	output [7:0] red,
	output [7:0] green,
	output [7:0] blue,
	output VA,
	output [9:0] h_cnt,
	output [9:0] v_cnt
);

//video_active wire
wire video_active;

//hold values from counters so we can assign sync signals
wire [9:0] h_val;
wire [9:0] v_val;

//enables for each counter
wire h_en;
wire v_en;

//color wires
wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;

/*
//25Mhz clk signal for counters
clk_wiz_0 VGA_clk
(
	.clk_out2(pix_clk_5x),
	.clk_out1(pix_clk),  //25Mhz Pixel clock 
	.reset(rst),  // Status and control signals
	.locked(wiz_locked),
	.clk_in1(clk)  // Clock in ports
);
*/

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

//allow ROM data to be displayed during box_time
assign red = (video_active && box_time) ? char_red : back_red;
assign green = (video_active && box_time) ? char_green : back_green;
assign blue = (video_active && box_time) ? char_blue : back_blue;

//external output for video_active to go to HDMI IP
assign VA = video_active;

//VGA counter values
assign h_cnt = h_val;
assign v_cnt = v_val;

endmodule