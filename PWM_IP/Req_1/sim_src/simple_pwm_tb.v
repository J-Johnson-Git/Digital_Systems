`timescale 1ns / 1ps

module simple_pwm_tb;

reg clk = 0;
reg [7:0] sw = 0;
wire led;

pwm_simple uut
(
	.clk(clk),
	.sw(sw),
	.led(led)
);

always #1 clk = ~clk;
initial 
begin
	sw = 1;
	#50000;
	
	sw = 128;
	#50000;
	
	sw = 255;
	#50000;
	
	sw = 0; 
	#50000;
	
	$finish;
end

    
endmodule
