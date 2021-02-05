library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- state machine for stopwatch
-- creates signals for start, stop, increment

entity rtm_controller is
	port 
	( 
		i_clk : in std_logic;  
		i_rst : in std_logic;
		i_start : in std_logic;
		i_reached_rand_num : in std_logic;  -- tells us when the random number has been counted to 
		o_en : out std_logic;  -- enable for random number counter
		o_en_bcd : out std_logic;   -- enable for bcd counters
		o_led : out std_logic  -- turns on the LED indicating it's time to react
	);
end rtm_controller;

architecture Behavioral of rtm_controller is
	-- s0 = wait for start
	-- s1 = counting up to random number
	-- s2 = reacted
	-- s3 = show average?
	type state is (s0, s1, s2, s3);  
	signal r_state_reg : state;
	signal r_en : std_logic;

begin
	process (i_clk, i_rst)
	begin
		if (i_rst = '1') then
			r_state_reg <= s0;
		elsif (i_clk'event and i_clk = '1') then
			case (r_state_reg) is
				when s0 =>  -- rst into this, wait for start
					if (i_start = '1') then
						r_state_reg <= s1;
					else 
						r_state_reg <= s0;
					end if;
				when s1 =>  -- counting up to random number
					if (i_reached_rand_num = '1') then
						r_state_reg <= s2;
					else 
						r_state_reg <= s1;
					end if;
				when s2 => -- wait for user to react
					if (i_start = '1') then
						r_state_reg <= s3;
					else 
						r_state_reg <= s2;
					end if;
				when s3 => 
					if (i_start = '1') then
						r_state_reg <= s3;
					elsif (i_start = '0') then
						r_state_reg <= s0;
					else 
						r_state_reg <= s3;
					end if;
			end case;
		end if;
	end process;
	
	process (r_state_reg, i_clk)  -- handles output enable
	begin
		if (i_clk'event and i_clk = '1') then
			case (r_state_reg) is
				when s0 => 
					o_en_bcd <= '0';
					o_led <= '0';
					r_en <= '0';
				when s1 =>
					o_en_bcd <= '0';
					o_led <= '0';
					r_en <= '1';
				when s2 => 
					o_en_bcd <= '1';
					o_led <= '1';
					r_en <= '0';
				when s3 =>
					o_en_bcd <= '0';
					o_led <= '0';
					r_en <= '0';
			end case;
		end if;
	end process;
	
	o_en <= r_en;

end Behavioral;
