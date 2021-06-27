`timescale 1ns / 1ps

module uart_tx #(parameter CLK_CYCLES = 0, parameter BIT_NUM = 0) 
(
    input i_clk,
    input i_en,  //enable when we want to dump data into tx
    input [(BIT_NUM - 1):0] i_data,
    output o_tx_data
);

localparam IDLE = 0;
localparam START = 1;
localparam DATA = 2;
localparam STOP = 3;

reg [1:0] r_SM = 0;
reg [15:0] r_counter = 0;

always @ (posedge(i_clk))
begin
    case (r_SM)
        IDLE:
        begin
            o_tx_data <= 1'd1;
            if (i_en == 1'd1)
            begin
                r_SM <= START;
            end
            else
            begin
                r_SM <= IDLE;
            end
        end

        START:
        begin
            o_tx_data <= 1'd0;
            if (r_counter == (CLK_CYCLE - 1))
            begin
                r_SM <= DATA;
                r_counter <= 0;
            end
            else
            begin
                r_counter <= r_counter + 1;
            end
        end

        DATA:
        begin
            
        end
    endcase
end

endmodule
