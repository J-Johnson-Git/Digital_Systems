library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- decides which anode to turn on or off based on counter value

entity sevenseg_anode_decoder is
    port 
	( 
		i_counter : in STD_LOGIC_VECTOR (1 downto 0);
		o_anode : out std_logic_vector (3 downto 0);
		o_dp : out std_logic
	);
end sevenseg_anode_decoder;

architecture Behavioral of sevenseg_anode_decoder is

signal r_anode : std_logic_vector (3 downto 0) := (others => '0');
signal r_dp : std_logic := '0';

begin
	decoder : process (i_counter)
	begin
		--o_anode <= "1110" when i_counter = "00" else "0000";
		--o_anode <= "1101" when i_counter = "01" else "0000";
		--o_anode <= "1011" when i_counter = "10" else "0000";
		--o_anode <= "0111" when i_counter = "11" else "0000";
		case (i_counter) is
			when "00" => 
				r_anode <= "1110";
			when "01" => 
				r_anode <= "1101";
			when "10" =>
				r_anode <= "1011";
			when "11" =>
				r_anode <= "0111";
		end case;
	end process decoder;
	
	dp : process (i_counter)
	begin
		--o_dp <= "0" when i_counter = "0111" else "1";
		case (i_counter) is 
			when "00" => 
				r_dp <= '1';
			when "01" => 
				r_dp <= '1';
			when "10" =>
				r_dp <= '1';
			when "11" =>
				r_dp <= '0';
		end case;
	end process dp;
	
	o_anode <= r_anode;
	o_dp <= r_dp;
end Behavioral;
