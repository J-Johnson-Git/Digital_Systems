`timescale 1ns / 1ps

module char_rom_tb(
    );

wire [15:0] DO;
reg pix_clk = 1'b1;
reg [10:0] addr = 11'h310;

// Generate pix_clk
always
begin
    #5 pix_clk <= ~pix_clk;
end


// Increment Address every clock cycle
always @ (posedge pix_clk)
begin
    addr <= addr - 1'b1;
end




char_rom char_rom_inst (
    .DO(DO),       // Output data, width defined by READ_WIDTH parameter
    .ADDR(addr),   // Input address, width defined by read/write port depth
    .CLK(pix_clk),     // 1-bit input clock
    .DI(16'h0),       // Input data port, width defined by WRITE_WIDTH parameter
    .EN(1'b1),       // 1-bit input RAM enable
    .REGCE(1'b0), // 1-bit input output register enable
    .RST(1'b0),     // 1-bit input reset
    .WE(2'd0)        // Input write enable, width defined by write port depth
    );
	
initial
begin
	#1000;
	$finish;
end	
	
endmodule