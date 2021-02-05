library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- mux for cathode decoder that picks which digit to pass to 
-- the cathode decoder

entity sevenseg_mux is
    port 
	( 
		i_bcd_0 : in std_logic_vector (3 downto 0);
        i_bcd_1 : in std_logic_vector (3 downto 0);
        i_bcd_2 : in std_logic_vector (3 downto 0);
        i_bcd_3 : in std_logic_vector (3 downto 0);
		i_sel : in std_logic_vector (1 downto 0);
		o_digit : out std_logic_vector (3 downto 0)
	);
end sevenseg_mux;

architecture Behavioral of sevenseg_mux is
begin
	--o_digit <= i_bcd_0 when i_sel = "00" else "0000";
	--o_digit <= i_bcd_1 when i_sel = "01" else "0000";
	--o_digit <= i_bcd_2 when i_sel = "10" else "0000";
	--o_digit <= i_bcd_3 when i_sel = "11" else "0000";
	process (i_bcd_0, i_bcd_1, i_bcd_2, i_bcd_3, i_sel)
	begin
		if (i_sel = "00") then
			o_digit <= i_bcd_0;
		elsif (i_sel = "01") then
			o_digit <= i_bcd_1;
		elsif (i_sel = "10") then
			o_digit <= i_bcd_2;
		else 
			o_digit <= i_bcd_3;
		end if;
	end process;
end Behavioral;
