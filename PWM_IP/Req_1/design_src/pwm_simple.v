/*
`timescale 1ns / 1ps


	Project 4 Req 2
	The enable and duty cycle are programmed through AXI registers, and this module is instantiated 4 times
	in the AXI device for each LED LD3-LD0


module pwm_simple_indiv_LED
(
	input clk,
	input en,
	input [9:0] duty_cycle,
	output led
);

reg [7:0] counter = 0;  //internal counter
reg [31:0] PWM_freq = 100000;  //divider number

always @ (posedge (clk))
begin
	if (counter < PWM_freq) counter <= counter + 1'b1;
	else counter <= 8'b0;
end

assign led = ((en) && (counter < duty_cycle)) ? 1'b1: 1'b0; 

endmodule
*/

`timescale 1ns / 1ps

/*
	Project 4 Req 1
	Takes input from the switches to form a duty cycle for basic PWM that controls
	one of the LEDs. 
	Resolution is controlled by PWM_freq register. 
	This version will be expanded with AXI programmable registers
*/

module pwm_simple
(
	input clk,
	input [7:0] sw,
	output led
);

reg [7:0] counter = 0;  //internal counter
reg [31:0] PWM_freq = 100000;  //divider number
reg [7:0] PWM_duty_cycle = 50;  //programmable register in future versions

always @ (posedge (clk))
begin
	if (counter < PWM_freq) counter <= counter + 1'b1;
	else counter <= 8'b0;
end

//assign led = (counter > PWM_duty_cycle) ? 1'b0: 1'b1;  for reg version
assign led = (counter > sw) ? 1'b0: 1'b1;  //the duty cycle is whatever the < value is 

endmodule