`timescale 1ns / 1ps

/*
	Should read off the bits in order from left to right of ROM contents,
	left to right 
*/

module ROM_reader_tb();

reg [9:0] x_pos = 5;
reg [9:0] h_val = 0;
reg [15:0] ROM = 16'd120;
wire ROM_MSB_bit;
	
ROM_reader uut
(
	.x_pos(x_pos),
	.h_val(h_val),
	.ROM(ROM),
	.ROM_MSB_bit(ROM_MSB_bit)
);

always #20 h_val = h_val + 1;

initial
begin
	#10000;
	$finish;
end

endmodule
