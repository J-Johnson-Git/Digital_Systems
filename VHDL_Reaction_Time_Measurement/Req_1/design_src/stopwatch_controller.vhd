library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- state machine for stopwatch
-- creates signals for start, stop, increment

entity stopwatch_controller is
	port 
	( 
		i_clk : in std_logic;  
		i_rst : in std_logic;
		i_start : in std_logic;
		i_stop : in std_logic;
		i_incr : in std_logic;
		o_en : out std_logic  -- enable for counters
	);
end stopwatch_controller;

architecture Behavioral of stopwatch_controller is
	-- s0 = hold
	-- s1 = start 
	-- s2 = stop
	-- s3 = incr
	-- s4 hold for incr
	type state is (s0, s1, s2, s3, s4);  
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
					elsif (i_incr = '1') then
						r_state_reg <= s3;
					else 
						r_state_reg <= s0;
					end if;
				when s1 =>  -- running normally
					if (i_stop = '1') then
						r_state_reg <= s2;
					elsif (i_incr = '1') then
						r_state_reg <= s3;
					else 
						r_state_reg <= s1;
					end if;
				when s2 => -- stopped
					if (i_start = '1') then
						r_state_reg <= s1;
					elsif (i_incr = '1') then
						r_state_reg <= s3;
					else
						r_state_reg <= s2;
					end if;
				when s3 => -- incr
					r_state_reg <= s4;
				when s4 => 
					if (i_incr = '1') then
						r_state_reg <= s4;
					else
						r_state_reg <= s0;
					end if;
			end case;
		end if;
	end process;
	
	process (r_state_reg)  -- handles output enable
	begin
		case (r_state_reg) is
			when s0 => 
				r_en <= '0';
			when s1 =>
				r_en <= '1';
			when s2 => 
				r_en <= '0';
			when s3 => 
				r_en <= '1';
			when s4 =>
				r_en <= '0';
		end case;
	end process;
	
	o_en <= r_en;

end Behavioral;
