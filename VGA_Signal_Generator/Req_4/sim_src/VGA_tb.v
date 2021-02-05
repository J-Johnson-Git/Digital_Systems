`timescale 1ns / 1ps

module VGA_tb();

reg clk = 0;
reg rst = 0;

wire HS_out;
wire VS_out;
//wire [9:0] h_val_out;
//wire [9:0] v_val_out;
wire [3:0] red_out;
wire [3:0] green_out;
wire [3:0] blue_out;

VGA_sync uut
(
	.clk(clk),
	.rst(rst),
	.blue(blue_out),
	.green(green_out),
	.red(red_out),
	.HS(HS_out),
	.VS(VS_out)
);

always #5 clk = ~clk;

initial
begin
	#16_000_000;
	$finish;
end

endmodule
