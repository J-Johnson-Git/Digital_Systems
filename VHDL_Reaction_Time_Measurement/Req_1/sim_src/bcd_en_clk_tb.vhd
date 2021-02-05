library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity bcd_en_clk_tb is
end bcd_en_clk_tb;

architecture Behavioral of bcd_en_clk_tb is
	constant c_clk_period : time := 10 ns;
	

	-- test signals
	signal r_clk : std_logic := '0';
	signal r_rst : std_logic := '0';
	signal r_en : std_logic := '0';
	signal o_bcd_0 : std_logic_vector (3 downto 0) := "0000";
	signal o_bcd_1 : std_logic_vector (3 downto 0) := "0000";
	signal o_bcd_2 : std_logic_vector (3 downto 0) := "0000";
	signal o_bcd_3 : std_logic_vector (3 downto 0) := "0000";
	signal o_nxt_en : std_logic := '0';
	
	-- connection between bcd counters
	signal w_en_0 : std_logic := '0';
	signal w_en_1 : std_logic := '0';
	signal w_en_2 : std_logic := '0';

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
	uut_0 : bcd_en_clk
	port map
	(
		i_clk =>      r_clk,
		i_rst =>      r_rst, 
		i_en =>       r_en,
		o_bcd =>      o_bcd_0, 
		o_nxt_en =>   w_en_0
	);
	
	uut_1 : bcd_en_clk
	port map
	(
		i_clk =>      r_clk,
		i_rst =>      r_rst, 
		i_en =>       w_en_0,
		o_bcd =>      o_bcd_1, 
		o_nxt_en =>   w_en_1
	);
	
	uut_2 : bcd_en_clk
	port map
	(
		i_clk =>      r_clk,
		i_rst =>      r_rst, 
		i_en =>       w_en_1 and w_en_0,
		o_bcd =>      o_bcd_2, 
		o_nxt_en =>   w_en_2
	);
	
	uut_3 : bcd_en_clk
	port map
	(
		i_clk =>      r_clk,
		i_rst =>      r_rst, 
		i_en =>       w_en_1 and w_en_0 and w_en_2,
		o_bcd =>      o_bcd_3, 
		o_nxt_en =>   o_nxt_en
	);
	
	p_clk_gen : process is
	begin
		wait for c_clk_period / 2;
		r_clk <= not r_clk;
	end process p_clk_gen;
	
	process 
	begin
		r_en <= '1';
		wait for 1.001 sec;
		std.env.finish;
	end process;


end Behavioral;
