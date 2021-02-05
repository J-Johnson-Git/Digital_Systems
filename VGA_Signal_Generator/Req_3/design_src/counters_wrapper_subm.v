`timescale 1ns / 1ps

/*
	Wrapper for the two parameterized counters, Requirement 3 w/ILA
*/

module counters_wrapper_subm
(
	input clk,
	input rst,
	(* mark_debug = "true", keep = "true" *)
	input en, 
	(* mark_debug = "true", keep = "true" *)
	output A, 
	(* mark_debug = "true", keep = "true" *)
	output B
);

//switched inputs a_val and b_val to wires so I can view them on testbench
(* mark_debug = "true", keep = "true" *)
wire [9:0] a_val;
(* mark_debug = "true", keep = "true" *)
wire [9:0] b_val;

//7Mhz clk signal for counters
clk_wiz_0 clk_wizard
(
	.clk_out1(sev_clk),  //7Mhz clk
	.reset(rst),  // Status and control signals
	.locked(wiz_locked),
	.clk_in1(clk)  // Clock in ports from Blackboard
);


param_counter # ( .WIDTH(10), .MAX_VAL(823))
counter_A
(
	.rst(rst),
	.clk(sev_clk),
	.en(a_en && en),
	.count(a_val)
);

param_counter # ( .WIDTH(10), .MAX_VAL(600))
counter_B
(
	.rst(rst),
	.clk(sev_clk),
	.en(b_en && en),
	.count(b_val)
);

//leave counter_A enabled always
assign a_en = 1'b1;

//enable counter_B when counter_A hits 823 
assign b_en = (a_val == 823);

assign A = (a_val <= 412);
assign B = (b_val <= 300);

endmodule
