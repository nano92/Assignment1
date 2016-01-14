library lpm;
library ieee;
use ieee.std_logic_1164.all;
use lpm.lpm_components.all;

entity struct_key_loader is

port(	p1,p2,p3   : in std_logic_vector(3 downto 0);
		clk 		 	: in std_logic;
		load_key    : in std_logic;

		k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33 : out std_logic_vector(3 downto 0));

end struct_key_loader;

architecture behavior of struct_key_loader is


signal k13_reg,k12_reg,
		 k23_reg,k22_reg,
		 k33_reg,k32_reg: std_logic_vector(3 downto 0);
		 
begin

--------------------------Temp signals assigned to outputs---------------
k13 <= k13_reg;
k12 <= k12_reg;
k23 <= k23_reg;
k22 <= k22_reg;
k33 <= k33_reg;
k32 <= k32_reg;

--------------------------key registers----------------------------------
k11_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => p1, clock => clk, enable => load_key, q => k13_reg); 

k21_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => p2, clock => clk, enable => load_key, q => k23_reg); 

k31_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => p3, clock => clk, enable => load_key, q => k33_reg); 

k12_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data =>k13_reg , clock => clk, enable => load_key, q => k12_reg); 

k22_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => k23_reg, clock => clk, enable => load_key, q => k22_reg); 

k32_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => k33_reg, clock => clk, enable => load_key, q => k32_reg); 

k13_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => k12_reg, clock => clk, enable => load_key, q => k11); 

k23_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => k22_reg, clock => clk, enable => load_key, q => k21); 

k33_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => k32_reg, clock => clk, enable => load_key, q => k31); 

end behavior;