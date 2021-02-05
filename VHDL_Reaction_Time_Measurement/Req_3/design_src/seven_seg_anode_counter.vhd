library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- two bit counter for anode

entity seven_seg_anode_counter is
    port 
	( 
		i_clk : in std_logic;
		i_rst : in std_logic;
		o_counter : out std_logic_vector (1 downto 0)
	);
end seven_seg_anode_counter;

architecture Behavioral of seven_seg_anode_counter is

signal r_counter : std_logic_vector (1 downto 0) := (others => '0');

begin
	incr : process (i_clk, i_rst)
	begin
		if (rising_edge(i_clk)) then
			if (i_rst = '1') then
				r_counter <= (others => '0');
			else 
				r_counter <= r_counter + 1;
			end if;
		end if;
	end process incr;

o_counter <= r_counter;

end Behavioral;
