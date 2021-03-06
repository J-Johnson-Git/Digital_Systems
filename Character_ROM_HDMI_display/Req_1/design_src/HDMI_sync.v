`timescale 1ns / 1ps

/*
	HDMI generator, signals come from VGA controller, and get converted in 
	HDMI IP 
*/

module HDMI_sync
(
	input clk,
	input rst,
	output TMDS_CLK_P,          
    output TMDS_CLK_N,          
    output  [2:0] TMDS_DATA_P,  
    output  [2:0] TMDS_DATA_N
);

//VGA signals
wire [7:0] red;
wire [7:0] green;
wire [7:0] blue;
wire HS;
wire VS;
wire VA;

//clock wizard signals
wire pix_clk;
wire pix_clk_5x;
wire wiz_locked;


VGA_sync VGA_sync
(
	.clk(clk),
	.rst(rst),
	.HS(HS),
	.VS(VS),
	.red(red),
	.green(green),
	.blue(blue),
	.VA(VA),
	.pix_clk(pix_clk),
	.pix_clk_5x(pix_clk_5x),
	.wiz_locked(wiz_locked)
);

hdmi_tx_0 VGA_HDMI_conv
(
    .pix_clk(pix_clk),              
    .pix_clkx5(pix_clk_5x),            
    .pix_clk_locked(wiz_locked),       
    .rst(rst),                  
    .red(red),        
    .green(green),    
    .blue(blue),      
    .hsync(HS),                        
    .vsync(VS),                        
    .vde(VA),                                          
    .TMDS_CLK_P(TMDS_CLK_P),          
    .TMDS_CLK_N(TMDS_CLK_N),          
    .TMDS_DATA_P(TMDS_DATA_P),  
    .TMDS_DATA_N(TMDS_DATA_N)   
);

endmodule