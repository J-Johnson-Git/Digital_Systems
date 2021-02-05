`timescale 1ns / 1ps

/*
	tb for the wrapper for horiz and vert counter
*/

module counters_wrapper_tb();

reg clk = 0;
reg rst = 0;
reg en = 0;

wire A;
wire B;

wire [9:0] a_val;
wire [9:0] b_val;

counters_wrapper_subm uut 
(
	.clk(clk),
	.rst(rst),
	.en(en),
	.A(A),
	.B(B),
	.a_val_out(a_val),
	.b_val_out(b_val)
);

always #5 clk = ~clk;

initial 
begin
	en = 1;
	#5_000_000;
	
	en = 0;
	#500;
	
	rst = 1;
	#10;
	
	rst = 0;
	#100;
	
	$finish;
end


endmodule
