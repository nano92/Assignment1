----------------------------------------------------------------------
-- File name: key_loader.vhd
-- Author: Luis Gallet Zambrano - 260583750
-- Creation date: 01/13/16
-- Last revision date: 01/19/16
 
-- Description: It follows the FSM  model on the assignment description.
-- The FSM has 4 states, the keys ares loaded only when the load_key signal
-- is high.
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity key_loader is

port(	p1,p2,p3   : in std_logic_vector(3 downto 0);
		clk 		 	: in std_logic;
		load_key    : in std_logic;

		k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33 : out std_logic_vector(3 downto 0));

end key_loader;

architecture behavior of key_loader is

type STATE_TYPE is (idle,load_c1,load_c2,load_c3);
signal state: STATE_TYPE;


begin

process(clk,load_key)
	begin
		
		if (rising_edge(clk) AND load_key = '0') then
			state <= idle;
		
		elsif (rising_edge(clk) AND load_key = '1') then 
			case state is
				when idle=>
								
				k11<= p1;
				k21<= p2;
				k31<= p3;
				
				
				state <= load_c1;
				
				
				when load_c1=>
				
				k12<= p1;
				k22<= p2;
				k32<= p3;
				
				state <= load_c2;
				
				when load_c2=>
								
				k13<= p1;
				k23<= p2;
				k33<= p3;
				
				state <= load_c3;
				
				when load_c3=>
				
				state <= idle;
				
			end case;
		end if;
end process;
			
			
end behavior;