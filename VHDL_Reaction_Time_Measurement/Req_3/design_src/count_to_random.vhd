library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- counts up to a random number of seconds 
-- passed down through the AXI bus

-- may need enable from state machine

entity count_to_random is
	port 
	( 
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_en : in std_logic;
		i_num : in std_logic_vector (3 downto 0);
		o_done : out std_logic := '0'
	);
end count_to_random;

architecture Behavioral of count_to_random is	
	-- const to count up to a second
	constant sec_const : natural := 50000000;
	
	-- counts up to the sec const
	signal r_sec_indicator : natural range 0 to sec_const;
	
	-- signal that indicates one second on its neg edge
	signal r_sec_clk : std_logic := '0';
	
	-- counts actual seconds
	signal r_sec_counter : std_logic_vector (3 downto 0) := "0000";
begin
	-- process that indicates one second on the neg edge of r_sec_clk
	clk_div_sec : process (i_clk, i_rst)
	begin
		if (i_clk = '1' and i_clk'event) then
			r_sec_indicator <= r_sec_indicator + 1;
			if (i_rst = '1') then
				r_sec_indicator <= 0;
				r_sec_clk <= '0';
			elsif (r_sec_indicator = sec_const - 1) then
				r_sec_indicator <= 0;
				r_sec_clk <= not r_sec_clk;
			end if;
		end if;
	end process clk_div_sec;
	
	-- handles counting the seconds until i_num reached
	sec_counter : process (r_sec_clk, i_rst, i_en)
	begin
		if (i_rst = '1') then
			r_sec_counter <= "0000";
			o_done <= '0';
		elsif (r_sec_clk = '0' and r_sec_clk'event and i_en = '1') then
			r_sec_counter <= r_sec_counter + '1';
			if (r_sec_counter = i_num - '1') then
				o_done <= '1';
			end if;
		end if;
	end process sec_counter;

end Behavioral;
