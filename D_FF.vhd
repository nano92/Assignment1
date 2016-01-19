library ieee;
use ieee.std_logic_1164.all;

entity D_FF is
   port
   (
      clk : in std_logic;

		--enable : in std_logic := '1';
      
      d : in std_logic;

      q : out std_logic
   );

end D_FF;
 
architecture behavioral of D_FF is
begin
   process (clk) is
   begin
      if rising_edge(clk) then  
         --if (enable='1') then   
            q <= d;
         --end if;
      end if;
   end process;
end behavioral;