library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity rtm_wrapper is
	port 
	(
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_start : in std_logic;
		i_sel : in std_logic;
		i_num : in std_logic_vector (3 downto 0);
		o_cathode : out std_logic_vector (6 downto 0);
		o_anode : out std_logic_vector (3 downto 0);
		o_dp : out std_logic;
		o_led : out std_logic;
		o_divisor_wrap : out std_logic_vector (3 downto 0);
		i_bcd_return_0 : in std_logic_vector (3 downto 0);
		i_bcd_return_1 : in std_logic_vector (3 downto 0);
		i_bcd_return_2 : in std_logic_vector (3 downto 0);
		i_bcd_return_3 : in std_logic_vector (3 downto 0);
		o_bcd_0 : out std_logic_vector (3 downto 0);
		o_bcd_1 : out std_logic_vector (3 downto 0);
		o_bcd_2 : out std_logic_vector (3 downto 0);
		o_bcd_3 : out std_logic_vector (3 downto 0);
		o_bcd_capture_wrap : out std_logic;
		o_sum_div_wrap : out std_logic
	);
end rtm_wrapper;

architecture Behavioral of rtm_wrapper is

	signal w_clk_div : std_logic;
	signal w_bcd_0 : std_logic_vector (3 downto 0);  -- to 7seg from mux
	signal w_bcd_1 : std_logic_vector (3 downto 0);
	signal w_bcd_2 : std_logic_vector (3 downto 0);
	signal w_bcd_3 : std_logic_vector (3 downto 0);
	signal w_react_bcd_0 : std_logic_vector (3 downto 0);  -- from react timer to mux
	signal w_react_bcd_1 : std_logic_vector (3 downto 0);
	signal w_react_bcd_2 : std_logic_vector (3 downto 0);
	signal w_react_bcd_3 : std_logic_vector (3 downto 0);
	
	signal r_cathode : std_logic_vector (6 downto 0);
	signal r_anode : std_logic_vector (3 downto 0);
	signal r_dp : std_logic;
	signal w_en : std_logic;
	signal w_en_bcd : std_logic;
	signal w_done_counting_rand : std_logic;
	
	component avg_mux is
	port 
	( 
		i_sel : in std_logic;
		i_avg_0 : in std_logic_vector (3 downto 0);
		i_avg_1 : in std_logic_vector (3 downto 0);
		i_avg_2 : in std_logic_vector (3 downto 0);
		i_avg_3 : in std_logic_vector (3 downto 0);
		i_react_0 : in std_logic_vector (3 downto 0);
		i_react_1 : in std_logic_vector (3 downto 0);
		i_react_2 : in std_logic_vector (3 downto 0);
		i_react_3 : in std_logic_vector (3 downto 0);
		o_disp_0 : out std_logic_vector (3 downto 0);
		o_disp_1 : out std_logic_vector (3 downto 0);
		o_disp_2 : out std_logic_vector (3 downto 0);
		o_disp_3 : out std_logic_vector (3 downto 0)
	);
	end component avg_mux;
	
	component count_to_random is
	port 
	( 
		i_clk : in std_logic;
		i_rst : in std_logic;
		i_en : in std_logic;
		i_num : in std_logic_vector (3 downto 0);
		o_done : out std_logic := '0'
	);
	end component count_to_random;
	
	component rtm_controller is
		port 
		( 
			i_clk : in std_logic;  
			i_rst : in std_logic;
			i_start : in std_logic;
			i_reached_rand_num : in std_logic;  -- tells us when the random number has been counted to 
			o_en : out std_logic;  -- enable for random number counter
			o_en_bcd : out std_logic;   -- enable for bcd counters
			o_led : out std_logic;  -- turns on the LED indicating it's time to react
			o_divisor : out std_logic_vector (3 downto 0);
			o_bcd_capture : out std_logic;
			o_sum_div : out std_logic
		);
	end component rtm_controller;
	
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
	display_mux : avg_mux
	port map
	( 
		i_sel => i_sel,
		i_avg_0 => i_bcd_return_0,
		i_avg_1 => i_bcd_return_1,
		i_avg_2 => i_bcd_return_2,
		i_avg_3 => i_bcd_return_3,
		i_react_0 => w_react_bcd_0,
		i_react_1 => w_react_bcd_1,
		i_react_2 => w_react_bcd_2,
		i_react_3 => w_react_bcd_3,
		o_disp_0 => w_bcd_0,
		o_disp_1 => w_bcd_1,
		o_disp_2 => w_bcd_2,
		o_disp_3 => w_bcd_3
	);

	random_num_counter : count_to_random
	port map
	( 
		i_clk => i_clk,
		i_rst => i_rst,
		i_en => w_en,
		i_num => i_num,
		o_done => w_done_counting_rand  -- this will be en for counter later
	);
	
	state_machine : rtm_controller
	port map
	(
		i_clk => w_clk_div,
		i_rst => i_rst,
		i_start => i_start,
		i_reached_rand_num => w_done_counting_rand,
		o_en => w_en,
		o_led => o_led,
		o_en_bcd => w_en_bcd,
		o_divisor => o_divisor_wrap,
		o_bcd_capture => o_bcd_capture_wrap,
		o_sum_div => o_sum_div_wrap
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
		i_en => w_en_bcd,
		o_bcd_digits_0 => w_react_bcd_0,
		o_bcd_digits_1 => w_react_bcd_1,
		o_bcd_digits_2 => w_react_bcd_2,
		o_bcd_digits_3 => w_react_bcd_3
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
	o_bcd_0 <= w_bcd_0;
	o_bcd_1 <= w_bcd_1;
	o_bcd_2 <= w_bcd_2;
	o_bcd_3 <= w_bcd_3;
	
end Behavioral;
