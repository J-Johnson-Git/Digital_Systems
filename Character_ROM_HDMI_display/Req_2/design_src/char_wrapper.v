`timescale 1ns / 1ps

/*
	Overall wrapper for displaying characters from ROM through HMDI
*/

module char_wrapper
(
	input clk,
	input rst,
	output TMDS_CLK_P,          
    output TMDS_CLK_N,          
    output [2:0] TMDS_DATA_P,  
    output [2:0] TMDS_DATA_N
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

//output from ROM_mux, 8'd255 if a bit from ROM data is 1, 0 if it's zero
wire [7:0] character_data;

//address for ROM data
wire [10:0] ROM_addr;

//selection bit for ROM_mux to pick black or white
wire w_contents;

HDMI_sync HMDI
(
	.char_data(character_data),
	.clk(clk),
	.rst(rst),
	.TMDS_CLK_P(TMDS_CLK_P),          
    .TMDS_CLK_N(TMDS_CLK_N),          
    .TMDS_DATA_P(TMDS_DATA_P),  
    .TMDS_DATA_N(TMDS_DATA_N),
	.pix_clk_out(pix_clk),
	.pix_clk_5x_out(pix_clk_5x),
	.h_out(w_h_val),
	.v_out(w_v_val),
	.box_time(w_box_time)
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
	.x_pos(10'd144),  //these two inputs should have axi registers where we indicate pixels to start placing character
	.y_pos(10'd35),  
	.box_time(w_box_time)
);

addr_gen_combo addr_gen_combo
(
	.y_pos(10'd35),
	.v_val(w_v_val),
	.ascii_addr(7'h41),  //desired ascii character (AXI reg)
	.addr(ROM_addr) 
);

ROM_reader ROM_reader
(
	.x_pos(10'd144),
	.h_val(w_h_val),
	.ROM(DO_ROM),  
	.ROM_MSB_bit(w_contents)  
);

ROM_mux ROM_mux
(
	.sel(w_contents),
	.color(character_data)
);

endmodule
