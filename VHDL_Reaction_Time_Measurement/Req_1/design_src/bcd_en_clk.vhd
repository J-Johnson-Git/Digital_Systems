library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- should increment only if previous one hits 9

entity bcd_en_clk is
	port 
	( 
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_en : in std_logic;
		o_bcd : out std_logic_vector (3 downto 0);
		o_nxt_en : out std_logic
	);
end bcd_en_clk;

architecture Behavioral of bcd_en_clk is
	-- register that holds value of bcd counter
	signal r_digit : unsigned (3 downto 0) := "0000";
	signal r_nxt_en : std_logic := '0';
	
begin
	-- bcd output, gets value from register r_digit
	o_bcd <= std_logic_vector(r_digit);
	o_nxt_en <= r_nxt_en;

	incr: process (i_clk, i_rst, i_en)
	begin
		if (i_rst = '1') then
			r_digit <= (others => '0');
		elsif ((rising_edge(i_clk)) and (i_en = '1')) then
			if (r_digit = 9) then	
				r_digit <= (others => '0');
			else 
				r_digit <= r_digit + 1;
			end if;
		end if;
	end process incr;
	
	en : process (i_clk, i_rst, i_en, r_digit)
	begin
		if (i_rst = '1') then
			r_nxt_en <= '0';
		elsif (i_en = '1') then
			if (r_digit = 9) then	
				r_nxt_en <= '1';
			else 
				r_nxt_en <= '0';
			end if;
		end if;
	end process en;

end Behavioral;
