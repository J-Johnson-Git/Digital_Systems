library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- cathode decoder that chooses which parts of the display's digit to illumiate

entity sevenseg_cath_decoder is
    port 
	( 
		i_bcd : in STD_LOGIC_VECTOR (3 downto 0);
		o_cathode : out std_logic_vector (6 downto 0)
	);
end sevenseg_cath_decoder;

architecture Behavioral of sevenseg_cath_decoder is

signal r_cathode : std_logic_vector (6 downto 0) := (others => '0');

begin
	--o_cathode <= "1000000" when i_bcd = "0000" else "0000000";
	--o_cathode <= "1111001" when i_bcd = "0001" else "0000000";
	--o_cathode <= "0100100" when i_bcd = "0010" else "0000000";
	--o_cathode <= "0110000" when i_bcd = "0011" else "0000000";
	--o_cathode <= "0011001" when i_bcd = "0100" else "0000000";
	--o_cathode <= "0010010" when i_bcd = "0101" else "0000000";
	--o_cathode <= "0000010" when i_bcd = "0110" else "0000000";
	--o_cathode <= "1111000" when i_bcd = "0111" else "0000000";	
	--o_cathode <= "0000000" when i_bcd = "1000" else "0000000";	
	--o_cathode <= "0011000" when i_bcd = "1001" else "0000000";	
	decoder : process (i_bcd)
	begin 
		case (i_bcd) is
			when "0000" =>
				r_cathode <= "1000000";
			when "0001" => 
				r_cathode <= "1111001";
			when "0010" =>
				r_cathode <= "0100100";
			when "0011" => 
				r_cathode <= "0110000";
			when "0100" =>
				r_cathode <= "0011001";
			when "0101" =>
				r_cathode <= "0010010";
			when "0110" =>
				r_cathode <= "0000010";
			when "0111" =>
				r_cathode <= "1111000";
			when "1000" =>
				r_cathode <= "0000000";
			when "1001" =>
				r_cathode <= "0011000";
			when "1010" =>
				r_cathode <= "1111111";
			when "1011" =>
				r_cathode <= "1111111";
			when "1100" =>
				r_cathode <= "1111111";
			when "1101" =>
				r_cathode <= "1111111";
			when "1110" => 
				r_cathode <= "1111111";
			when "1111" =>
				r_cathode <= "1111111";
		end case;
	end process decoder;
	
o_cathode <= r_cathode;
end Behavioral;
