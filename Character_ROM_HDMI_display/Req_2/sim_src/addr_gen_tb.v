`timescale 1ns / 1ps

/*
	Testbench for address generator
*/

module addr_gen_tb();

reg [9:0] y_pos = 5;
reg [9:0] v_val = 0;
reg [6:0] ascii_addr = 7'h21;  //desired ascii character
wire [10:0] addr;  //concantonated ascii character address with counter value   

addr_gen_combo uut
(
	.y_pos(y_pos),
	.v_val(v_val),
	.ascii_addr(ascii_addr),
	.addr(addr)
);

always #5 v_val = v_val + 1;

initial
begin
	#500;
	$finish;
end

endmodule
