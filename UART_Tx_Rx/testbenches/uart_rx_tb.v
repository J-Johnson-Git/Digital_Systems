`timescale 1ns / 1ps

/*
	baud = 115200
	clk = 100MHz
*/

module uart_rx_tb();

localparam CLK_CYCLES = 868;
localparam BIT_NUM = 8;
localparam TIME_FOR_ONE_PULSE = 8681;  //8670

reg i_clk = 0;
reg r_rx_data_in = 1;
wire [(BIT_NUM - 1):0] o_rx_data;

uart_rx # (.CLK_CYCLES(CLK_CYCLES), .BIT_NUM(BIT_NUM)) uart_rx_inst
(
	.i_clk(i_clk),
	.i_rx_data_in(r_rx_data_in),
	.o_rx_data(o_rx_data)
);

always #5 i_clk = ~i_clk;

//bits are sent in MSB -> LSB order in this task
task serialize_message;
	input [7:0] i_message;
	integer i;
	begin
		//start bit
		r_rx_data_in = 1'd0;
		#TIME_FOR_ONE_PULSE;
		
		for (i = (BIT_NUM - 1); i >= 0; i = i - 1)  //sending bits from MSB to LSB 
		begin
			r_rx_data_in <= i_message[i];
			#TIME_FOR_ONE_PULSE;
		end
		
		//stop
		r_rx_data_in = 1'd1;
		#TIME_FOR_ONE_PULSE;  
	end
endtask

initial
begin
	#30000;
	serialize_message(8'h65);
	#20000;
	$finish;
end

endmodule
