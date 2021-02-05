library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity display_clk_div_tb is
end display_clk_div_tb;

architecture Behavioral of display_clk_div_tb is
	-- 100MHz = 10ns
	constant c_clk_period : time := 10 ns;
	
	signal r_clk : std_logic := '0';
	signal w_clk_div : std_logic := '0';
	
	component display_clk_div is
	port 
	(
		i_clk : in std_logic;
		o_clk_div : out std_logic
	);
	end component display_clk_div;
begin
	uut : display_clk_div
	port map
	(
		i_clk => r_clk,
		o_clk_div => w_clk_div
	);
	
	p_clk_gen : process is
	begin
		wait for c_clk_period / 2;
		r_clk <= not r_clk;
	end process p_clk_gen;
	
	process
	begin
		wait for 3 sec;
	end process;


end Behavioral;
