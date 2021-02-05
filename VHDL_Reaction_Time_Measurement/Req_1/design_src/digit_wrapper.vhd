library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Wrapper for the 4 individual bcd counters, connects the increment
-- signals in 'digit_incrementer' to bcd counters for each digit

entity digit_wrapper is
	Port 
	( 
		i_clk : in std_logic;  --needs 1khz clk from display
		i_rst : in std_logic;
		i_en : in std_logic;
		o_bcd_digits_0 : out std_logic_vector (3 downto 0);
		o_bcd_digits_1 : out std_logic_vector (3 downto 0);
		o_bcd_digits_2 : out std_logic_vector (3 downto 0);
		o_bcd_digits_3 : out std_logic_vector (3 downto 0)
	);		
end digit_wrapper;

architecture Behavioral of digit_wrapper is

	-- connection between bcd counters
	signal w_en_0 : std_logic := '0';
	signal w_en_1 : std_logic := '0';
	signal w_en_2 : std_logic := '0';

	-- component description of one bcd counter
	component bcd_en_clk is
		port 
		( 
			i_clk : in std_logic;
			i_rst : in std_logic;
			i_en : in std_logic;
			o_bcd : out std_logic_vector (3 downto 0);
			o_nxt_en : out std_logic
		);
	end component bcd_en_clk;

begin
	bcd_0 : bcd_en_clk
	port map
	(
		i_clk => i_clk,
		i_rst => i_rst,
		i_en => i_en,
		o_bcd => o_bcd_digits_0,
		o_nxt_en => w_en_0
	);
	
	bcd_1 : bcd_en_clk
	port map
	(
		i_clk => i_clk,
		i_rst => i_rst,
		i_en => w_en_0,
		o_bcd => o_bcd_digits_1,
		o_nxt_en => w_en_1
	);
	
	bcd_2 : bcd_en_clk
	port map
	(
		i_clk => i_clk,
		i_rst => i_rst,
		i_en => w_en_0 and w_en_1,
		o_bcd => o_bcd_digits_2,
		o_nxt_en => w_en_2
	);
	
	bcd_3 : bcd_en_clk
	port map
	(
		i_clk => i_clk,
		i_rst => i_rst,
		i_en => w_en_0 and w_en_1 and w_en_2,
		o_bcd => o_bcd_digits_3,
		o_nxt_en => open
	);

end Behavioral;
