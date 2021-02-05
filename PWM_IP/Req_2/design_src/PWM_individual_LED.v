`timescale 1ns / 1ps

/*
	Project 4 Req 2
	The enable and duty cycle are programmed through AXI registers, and this module is instantiated 4 times
	in the AXI device for each LED LD3-LD0
*/

module pwm_simple_indiv_LED
(
	input clk,
	input en,
	input [9:0] duty_cycle,
	output led
);

reg [7:0] counter = 0;  //internal counter
reg [31:0] PWM_freq = 100000;  //divider number, describes PWM "window", amount between bursts 

always @ (posedge (clk))
begin
	if (counter < PWM_freq) counter <= counter + 1'b1;
	else counter <= 8'b0;
end

assign led = ((en) && (counter < duty_cycle)) ? 1'b1: 1'b0; //if enable high and counter less than duty cycle value, LED goes high

endmodule