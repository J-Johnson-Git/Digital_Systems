library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity display_clk_div is
	port 
	(
		i_clk : in std_logic;
		o_clk_div : out std_logic
	);
end display_clk_div;

architecture Behavioral of display_clk_div is
	signal r_counter : integer := 1;
	signal r_temp : std_logic := '0';

begin
	process (i_clk, r_temp)
	begin
		if (i_clk = '1' and i_clk'event) then
			r_counter <= r_counter + 1;
			if (r_counter = 50000) then
				r_temp <= not r_temp;
				r_counter <= 1;
			end if;
		end if;
		o_clk_div <= r_temp;
	end process;

end Behavioral;
