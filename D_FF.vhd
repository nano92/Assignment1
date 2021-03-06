----------------------------------------------------------------------
-- File name: D_FF.vhd
-- Author: Luis Gallet Zambrano - 260583750
-- Creation date: 01/19/16
-- Last revision date: 01/19/16
-- Description: D-Flip Flop deisigned to latch the encrypt signal. 
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity D_FF is
   port
   (
      clk : in std_logic;
      
      d : in std_logic;

      q : out std_logic
   );

end D_FF;
 
architecture behavioral of D_FF is
begin
   process (clk) is
   begin
      if rising_edge(clk) then  
           q <= d;
      end if;
   end process;
end behavioral;