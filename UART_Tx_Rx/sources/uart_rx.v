`timescale 1ns / 1ps

/*
	RX module for UART communication
	CLK_CYCLES = clk_freq / baud rate = (100_000_000)/(115200) = 868
	stores incoming bits into an output register in descending order
*/

module uart_rx #(parameter CLK_CYCLES = 0, parameter BIT_NUM = 0) 
(
	input i_clk,
	input i_rx_data_in,
	output [(BIT_NUM - 1):0] o_rx_data
);

reg [1:0] r_SM = 2'd0;
reg [15:0] r_counter = 16'd0;  //counter for counting the clock cycles for each bit
reg r_rx_temp = 1'd1;
reg r_rx_data = 1'd1;
reg [3:0] r_num_bits = 4'd0;  //used for counting which data bit we are picking to output
reg [(BIT_NUM - 1):0] r_rx_storage = 0;

localparam IDLE = 0;
localparam START = 1;
localparam DATA = 2;
localparam STOP = 3;


//placing two FFs between input and data to remove metastability
always @ (posedge(i_clk))
begin
	r_rx_temp <= i_rx_data_in;
	r_rx_data <= r_rx_temp;
end

always @ (posedge(i_clk))
begin
	case (r_SM)
		IDLE:
		begin
			r_num_bits <= 0;
			r_counter <= 0;
			if (r_rx_data == 0)
			begin
				r_SM <= START;
			end
			else
			begin
				r_SM <= IDLE;
			end
		end
			
		//start counting up until middle of start bit so we can sample
		START:
		begin
			if (r_counter == (CLK_CYCLES - 1) / 2)
			begin
				if (r_rx_data == 0)  //checking the middle
				begin
					r_SM <= DATA;  //NEED TO WAIT ANOTHER (CLK_CYCLES - 1) / 2 TIME SPAN B4 SWITCHING STATES
					r_counter <= 0;
				end
				else
				begin
					r_SM <= IDLE;
					r_counter <= 0;
				end
			end
			r_counter = r_counter + 1;
		end
		
		
		DATA:
		begin
			if (r_counter == (CLK_CYCLES - 1))  //time to sample, midpoint of bit
			begin
				r_counter <= 0;
				r_rx_storage[(BIT_NUM - r_num_bits - 1)] <= r_rx_data;  //storing bits starting at MSB and decreasing to match task in tb
				r_num_bits <= r_num_bits + 1;
				
				if (r_num_bits == (BIT_NUM - 1))
				begin
					r_SM <= STOP;
				end
				else
				begin
					r_SM <= DATA;
				end
			end
			else
			begin
				r_counter <= r_counter + 1;
				r_SM <= DATA;
			end
		end
		
		STOP:
		begin
			if (r_counter == (CLK_CYCLES - 1) / 2)
			begin
				r_SM <= IDLE;
			end
			else
			begin
				r_counter <= r_counter + 1;
				r_SM <= STOP;
			end
		end
	default:
		r_SM <= IDLE;
	endcase
end

assign o_rx_data = r_rx_storage;

endmodule
