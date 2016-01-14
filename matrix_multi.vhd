library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity matrix_multi is

port(	p1,p2,p3,
		k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33: in std_logic_vector(3 downto 0);
		
		clk: 			 in std_logic;
		c1,c2,c3:    out std_logic_vector(3 downto 0));

end matrix_multi;

architecture behavior of matrix_multi is

signal temp_p1,temp_p2,temp_p3: std_logic_vector(3 downto 0);
signal temp_c1,temp_c2,temp_c3: std_logic_vector(7 downto 0);

begin

process(clk) begin

if (clk'EVENT AND clk = '1') then --rising edge
    temp_p1 <= p1;
	 temp_p2 <= p2;
	 temp_p3 <= p3;
	 
	 c1 <= temp_c1(3 downto 0);
	 c2 <= temp_c2(3 downto 0);
	 c3 <= temp_c3(3 downto 0);

end if;
end process;

	
	temp_c1 <= (temp_p1*k11) + (temp_p2*k21) + (temp_p3*k31);
	temp_c2 <= (temp_p1*k12) + (temp_p2*k22) + (temp_p3*k32);
	temp_c3 <= (temp_p1*k13) + (temp_p2*k23) + (temp_p3*k33);
	
end behavior;
