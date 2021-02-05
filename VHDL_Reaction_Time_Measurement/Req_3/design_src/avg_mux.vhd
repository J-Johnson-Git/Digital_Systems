library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- mux that switches between average value and current reaction 
-- sends to 7seg 

entity avg_mux is
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
end avg_mux;

architecture Behavioral of avg_mux is
begin
	o_disp_0 <= i_avg_0 when (i_sel = '1') else i_react_0;
	o_disp_1 <= i_avg_1 when (i_sel = '1') else i_react_1;
	o_disp_2 <= i_avg_2 when (i_sel = '1') else i_react_2;
	o_disp_3 <= i_avg_3 when (i_sel = '1') else i_react_3;

end Behavioral;
