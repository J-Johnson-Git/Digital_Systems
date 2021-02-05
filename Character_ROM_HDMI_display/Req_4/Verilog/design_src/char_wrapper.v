`timescale 1ns / 1ps

/*
	Overall wrapper for displaying characters from ROM through HMDI
*/

module char_wrapper
(
	input [9:0] x_pos,
	input [9:0] y_pos,
	input [6:0] char_sel,
	input [7:0] back_red,
	input [7:0] back_green,
	input [7:0] back_blue,
	input [7:0] char_red,
	input [7:0] char_green,
	input [7:0] char_blue,	
	input pix_clk,
	input rst,
	output HS_out,
	output VS_out,
	output VA_out,
	output [7:0] red_out,
	output [7:0] green_out,
	output [7:0] blue_out
);

//clocks and VGA signals
wire pix_clk;
wire pix_clk_5x;
wire clk_div;
wire [9:0] w_h_val;
wire [9:0] w_v_val;
wire VA;

//asserted when we are inside 16 x 16 display box
wire w_box_time;

//ROM data
wire [15:0] DO_ROM;

//output from ROM_mux, selects the amounts of each color
wire [7:0] red_char_data;
wire [7:0] green_char_data;
wire [7:0] blue_char_data;

//address for ROM data
wire [10:0] ROM_addr;

//selection bit for ROM_mux to pick black or white
wire w_contents;


VGA_sync VGA_sync
(
	.back_red(back_red),
	.back_green(back_green),
	.back_blue(back_blue),
	.pix_clk(pix_clk),
	.rst(rst),
	.char_red(red_char_data),
	.char_green(green_char_data),
	.char_blue(blue_char_data),
	.box_time(w_box_time),
	.HS(HS_out),
	.VS(VS_out),
	.red(red_out),
	.green(green_out),
	.blue(blue_out),
	.VA(VA_out),
	.h_cnt(w_h_val),
	.v_cnt(w_v_val)
);

char_rom ROM
(
   .DO(DO_ROM),     // Output data, width defined by READ_WIDTH parameter [15:0]
   .ADDR(ROM_addr),   // Input address, width defined by read/write port depth [10:0]
   .CLK(pix_clk),           // 1-bit input clock (pix_clk)
   .DI(16'd0),      // Input data port, width defined by WRITE_WIDTH parameter [15:0] 
   .EN(1'd1),            // 1-bit input RAM enable
   .REGCE(1'd0),         // 1-bit input output register enable
   .RST(1'd0),           // 1-bit input reset
   .WE(2'd0)             // Input write enable, width defined by write port depth [1:0]
);

pulse_indicator pulse_indicator
(
	.h_val(w_h_val),
	.v_val(w_v_val),
	.x_pos(x_pos),  //10'd144
	.y_pos(y_pos),   //10'd35
	.box_time(w_box_time)
);

addr_gen_combo addr_gen_combo
(
	.y_pos(y_pos),  //10'd35
	.v_val(w_v_val),
	.ascii_addr(char_sel),  //7'h41
	.addr(ROM_addr) 
);

ROM_reader ROM_reader
(
	.x_pos(x_pos),  //10'd144
	.h_val(w_h_val),
	.ROM(DO_ROM),  
	.ROM_MSB_bit(w_contents)  
);

ROM_mux ROM_mux
(
	.sel(w_contents),
	.red(red_char_data),
	.green(green_char_data),
	.blue(blue_char_data),
	.char_red(char_red),
	.char_green(char_green),
	.char_blue(char_blue)
);

endmodule
