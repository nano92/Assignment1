----------------------------------------------------------------------
-- File name: struct_matrix_multi.vhd
-- Author: Luis Gallet Zambrano - 260583750
-- Creation date: 01/12/16
-- Last revision date: 01/12/16
 
-- Description: Use Flip-Flops to latch the inputs and also to write
-- in the outputs. Uses 3 matrix_multi_sub modules; one for each output.
----------------------------------------------------------------------
library altera_mf;
library lpm;
library ieee;
use ieee.std_logic_1164.all;
use lpm.lpm_components.all;

entity struct_matrix_multi is

port(	p1,p2,p3,
		k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33: in std_logic_vector(3 downto 0);
		
		clk: 			 in std_logic;
		c1,c2,c3:    out std_logic_vector(3 downto 0));

end struct_matrix_multi;

architecture behavior of struct_matrix_multi is
signal temp_p1,temp_p2,temp_p3: std_logic_vector(3 downto 0);
signal temp_c1,temp_c2,temp_c3: std_logic_vector(3 downto 0);

-----------multiplier component instantiaiton-------------------
component matrix_multi_sub is

port(	p1,p2,p3,
		k1X,k2X,k3X: in std_logic_vector(3 downto 0);
		
		cX:    		 out std_logic_vector(3 downto 0));

end component;

begin

---------------FF module to add registers to inputs and outputs-------------------
p1_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => p1, clock => clk, q => temp_p1); 
p2_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => p2, clock => clk, q => temp_p2); 

p3_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => p3, clock => clk, q => temp_p3); 

c1_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => temp_c1, clock => clk, q => c1); 

c2_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => temp_c2, clock => clk, q => c2); 

c3_FF : LPM_FF

GENERIC MAP (
lpm_width => 4
)
PORT MAP (data => temp_c3, clock => clk, q => c3);


--------------------multiplier sub modules for each output-----------------

multi_sub_c1 : matrix_multi_sub 
				
				PORT MAP(
								p1=>temp_p1, 
								p2=>temp_p2, 
								p3=>temp_p3, 
								k1X=>k11, 
								k2X=>k21, 
								k3X=>k31, 
								cX=> temp_c1
							);
							
multi_sub_c2 : matrix_multi_sub 
				
				PORT MAP(
								p1=>temp_p1, 
								p2=>temp_p2, 
								p3=>temp_p3, 
								k1X=>k12, 
								k2X=>k22, 
								k3X=>k32, 
								cX=> temp_c2
							);

multi_sub_c3 : matrix_multi_sub

				PORT MAP(
								p1=>temp_p1, 
								p2=>temp_p2, 
								p3=>temp_p3, 
								k1X=>k13, 
								k2X=>k23, 
								k3X=>k33,  
								cX=> temp_c3
							);
							


end behavior;