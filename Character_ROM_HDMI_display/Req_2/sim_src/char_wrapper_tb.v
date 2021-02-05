`timescale 1ns / 1ps

/*
	Overall tb
*/

module char_wrapper_tb();

reg clk = 0;
reg rst = 0;
wire [7:0] char_data;

char_wrapper uut
(
	.clk(clk),
	.rst(rst),
	.char_data_out(char_data)
);

always #5 clk = ~clk;

initial
begin
	#10000;
	$finish;
end

endmodule
