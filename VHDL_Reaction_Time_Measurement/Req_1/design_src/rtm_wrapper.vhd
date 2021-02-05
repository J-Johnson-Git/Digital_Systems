library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity stopwatch_wrapper is
	port 
	(
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_start : in std_logic;
		i_stop : in std_logic;
		i_incr : in std_logic;
		o_cathode : out std_logic_vector (6 downto 0);
		o_anode : out std_logic_vector (3 downto 0);
		o_dp : out std_logic
	);
end stopwatch_wrapper;

architecture Behavioral of stopwatch_wrapper is

	signal w_clk_div : std_logic;
	signal w_bcd_0 : std_logic_vector (3 downto 0);
	signal w_bcd_1 : std_logic_vector (3 downto 0);
	signal w_bcd_2 : std_logic_vector (3 downto 0);
	signal w_bcd_3 : std_logic_vector (3 downto 0);
	signal r_cathode : std_logic_vector (6 downto 0);
	signal r_anode : std_logic_vector (3 downto 0);
	signal r_dp : std_logic;
	signal w_en : std_logic;
	
	component stopwatch_controller is
	port 
	( 
		i_clk : in std_logic;  
		i_rst : in std_logic;
		i_start : in std_logic;
		i_stop : in std_logic;
		i_incr : in std_logic;
		o_en : out std_logic  -- enable for counters
	);
	end component stopwatch_controller;
	
	component display_controller_wrapper is
	port 
	( 
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_bcd_0 : in std_logic_vector (3 downto 0);
		i_bcd_1 : in std_logic_vector (3 downto 0);
		i_bcd_2 : in std_logic_vector (3 downto 0);
		i_bcd_3 : in std_logic_vector (3 downto 0);
		o_cathode : out std_logic_vector (6 downto 0);
		o_anode : out std_logic_vector (3 downto 0);
		o_dp : out std_logic
	);
	end component display_controller_wrapper;
	
	component digit_wrapper is
	Port 
	( 
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_en : in std_logic;
		o_bcd_digits_0 : out std_logic_vector (3 downto 0);
		o_bcd_digits_1 : out std_logic_vector (3 downto 0);
		o_bcd_digits_2 : out std_logic_vector (3 downto 0);
		o_bcd_digits_3 : out std_logic_vector (3 downto 0)
	);		
	end component digit_wrapper;
	
	component display_clk_div is
	port 
	(
		i_clk : in std_logic;
		o_clk_div : out std_logic
	);
	end component display_clk_div;


begin
	state_machine : stopwatch_controller
	port map
	(
		i_clk => w_clk_div,
		i_rst => i_rst,
		i_start => i_start,
		i_stop => i_stop,
		i_incr => i_incr,
		o_en => w_en
	);
	
	clk_div : display_clk_div
	port map
	(
		i_clk => i_clk,
		o_clk_div => w_clk_div
	);
	
	
	bcd : digit_wrapper
	port map
	(
		i_clk => w_clk_div,
		i_rst => i_rst,
		i_en => w_en,
		o_bcd_digits_0 => w_bcd_0,
		o_bcd_digits_1 => w_bcd_1,
		o_bcd_digits_2 => w_bcd_2,
		o_bcd_digits_3 => w_bcd_3
	);
	
	sevenseg : display_controller_wrapper 
	port map
	(
		i_clk => w_clk_div,
		i_rst => i_rst,
		i_bcd_0 => w_bcd_0,
		i_bcd_1 => w_bcd_1,
		i_bcd_2 => w_bcd_2,
		i_bcd_3 => w_bcd_3,
		o_cathode => r_cathode,
		o_anode => r_anode,
		o_dp => r_dp
	);

	o_cathode <= r_cathode;
	o_anode <= r_anode;
	o_dp <= r_dp;

end Behavioral;
