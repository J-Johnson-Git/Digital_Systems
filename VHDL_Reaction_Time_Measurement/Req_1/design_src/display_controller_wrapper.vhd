library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- wrapper for 7seg display modules

entity display_controller_wrapper is
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
end display_controller_wrapper;

architecture Behavioral of display_controller_wrapper is

	signal w_two_bit_counter : std_logic_vector (1 downto 0);
	signal w_mux_to_cath : std_logic_vector (3 downto 0);
	signal r_cathode : std_logic_vector (6 downto 0);
	signal r_dp : std_logic;
	signal r_anode : std_logic_vector (3 downto 0);
	
	component sevenseg_cath_decoder is
		port 
		(
			i_bcd : in STD_LOGIC_VECTOR (3 downto 0);
			o_cathode : out std_logic_vector (6 downto 0)
		);
	end component sevenseg_cath_decoder;

	component sevenseg_anode_decoder is
		port
		(
			i_counter : in STD_LOGIC_VECTOR (1 downto 0);
			o_anode : out std_logic_vector (3 downto 0);
			o_dp : out std_logic
		);
	end component sevenseg_anode_decoder;
	
	component seven_seg_anode_counter is
		port
		(
			i_clk : in std_logic;
			i_rst : in std_logic;
			o_counter : out std_logic_vector (1 downto 0)		
		);
	end component seven_seg_anode_counter;

	component sevenseg_mux is
		port
		(
			i_bcd_0 : in std_logic_vector (3 downto 0);
			i_bcd_1 : in std_logic_vector (3 downto 0);
			i_bcd_2 : in std_logic_vector (3 downto 0);
			i_bcd_3 : in std_logic_vector (3 downto 0);
			i_sel : in std_logic_vector (1 downto 0);
			o_digit : out std_logic_vector (3 downto 0)
		);
	end component sevenseg_mux;
begin
	cath_decoder : sevenseg_cath_decoder
	port map
	(
		i_bcd => w_mux_to_cath,
		o_cathode => r_cathode
	);
	
	anode_decoder : sevenseg_anode_decoder
	port map
	(
		i_counter => w_two_bit_counter,
		o_anode => r_anode,
		o_dp => r_dp
	);
	
	anode_counter : seven_seg_anode_counter
	port map
	(
		i_clk => i_clk,
	    i_rst => i_rst,
	    o_counter => w_two_bit_counter
	);
	
	mux : sevenseg_mux
	port map
	(
		i_bcd_0 => i_bcd_0,
		i_bcd_1 => i_bcd_1,
		i_bcd_2 => i_bcd_2,
		i_bcd_3 => i_bcd_3,
		i_sel => w_two_bit_counter,
		o_digit => w_mux_to_cath
	);
	

	o_cathode <= r_cathode;
	o_anode <= r_anode;
	o_dp <= r_dp;
end Behavioral;
