`timescale 1ns / 1ps

/*
	Testbench for pulse_indicator, should be asserted within 16 x 16 box that starts at x_pos and y_pos
	With x_pos = 144 and y_pos = 35, box_active should be asserted with 
*/

module pulse_indicator_tb();

reg clk = 0;
reg rst = 0;
reg [9:0] x_pos = 144;
reg [9:0] y_pos = 35;
wire box_time;
reg [9:0] w_h_val = 0;
reg [9:0] w_v_val = 0;

pulse_indicator uut
(
	.h_val(w_h_val),
	.v_val(w_v_val),
	.x_pos(x_pos),
	.y_pos(y_pos),
	.box_time(box_time)
);

always #5 clk = ~clk;

initial
begin
	#10000;
	$finish;
end

endmodule
