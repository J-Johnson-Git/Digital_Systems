`timescale 1ns / 1ps

/*
	Wrapper for the two parameterized counters, Project 1 Requirement 1
*/

module counters_wrapper_subm
(
	input clk,
	input rst,
	input en, 
	output A, 
	output B,
	
	//verify a_val and b_val are causing A and B to be asserted at the right times
	//uncomment to use in simulation 'counter_wrapper_tb.v'
	output [9:0] a_val_out,
	output [9:0] b_val_out
);

//switched inputs a_val and b_val to wires so I can view them on testbench
wire [9:0] a_val;
wire [9:0] b_val;

param_counter # ( .WIDTH(10), .MAX_VAL(823))
counter_A
(
	.rst(rst),
	.clk(clk),
	.en(a_en),
	.count(a_val)
);

param_counter # ( .WIDTH(10), .MAX_VAL(600))
counter_B
(
	.rst(rst),
	.clk(clk),
	.en(b_en),
	.count(b_val)
);

//leave counter_A enabled always
assign a_en = 1'b1;

//enable counter_B when counter_A hits 823 
assign b_en = (a_val == 823);

assign A = (a_val <= 412);
assign B = (b_val <= 300);

//verify a_val and b_val are causing A and B to be asserted at the right times
//uncomment to use in simulation 'counter_wrapper_tb.v'
assign a_val_out = a_val;
assign b_val_out = b_val;

endmodule
