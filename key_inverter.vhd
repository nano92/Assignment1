----------------------------------------------------------------------
-- File name: key_inverter.vhd
-- Author: Luis Gallet Zambrano - 260583750
-- Creation date: 01/15/16
-- Last revision date: 01/19/16
 
-- Description: The decrypt operation is sepeareted in four: the cofactors 
-- computation, the determinant computation, the adjacent matrix computation
-- and inverted key matrix computation. All the operations were done in modulo-16.
-- In addition, a lpm_rom module is used to map the multiplicative inverse 
-- of the determinant.
----------------------------------------------------------------------
library ieee;
library lpm;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use lpm.lpm_components.all;

entity key_inverter is

port( ek11,ek12,ek13,
		ek21,ek22,ek23,
		ek31,ek32,ek33: in std_logic_vector(3 downto 0);
		
		clk: in std_logic;
		
		dk11,dk12,dk13,
		dk21,dk22,dk23,
		dk31,dk32,dk33: out std_logic_vector(3 downto 0));
		

end key_inverter;

architecture behavior of key_inverter is

signal temp_ek11,temp_ek12,temp_ek13,
		 temp_ek21,temp_ek22,temp_ek23,
		 temp_ek31,temp_ek32,temp_ek33: std_logic_vector(3 downto 0);
		
signal cof11,cof12,cof13,
		 cof21,cof22,cof23,
		 cof31,cof32,cof33: std_logic_vector(7 downto 0);

signal mult1_cof11,mult1_cof12,mult1_cof13,
		 mult1_cof21,mult1_cof22,mult1_cof23,
		 mult1_cof31,mult1_cof32,mult1_cof33: std_logic_vector(7 downto 0);

signal mult2_cof11,mult2_cof12,mult2_cof13,
		 mult2_cof21,mult2_cof22,mult2_cof23,
		 mult2_cof31,mult2_cof32,mult2_cof33: std_logic_vector(7 downto 0);

signal adj11,adj21,adj31,
		 adj12,adj22,adj32,
		 adj13,adj23,adj33: std_logic_vector(7 downto 0);
		 
signal det: std_logic_vector(7 downto 0);
signal temp_det1,temp_det2,temp_det3: std_logic_vector(7 downto 0);

signal inv_det: std_logic_vector(3 downto 0);

signal temp_dk11,temp_dk12,temp_dk13,
		 temp_dk21,temp_dk22,temp_dk23,
		 temp_dk31,temp_dk32,temp_dk33: std_logic_vector(7 downto 0);
		 
signal ek11_2,ek12_2,ek13_2: std_logic_vector(3 downto 0);
signal cof11_2,cof12_2,cof13_2: std_logic_vector(7 downto 0);
		 
--type STATE_TYPE is (s0,s1,s2,s3,s4);
--signal state: STATE_TYPE;

signal i : integer := 0;

begin
		temp_ek11 <= ek11;
		temp_ek12 <= ek12;
		temp_ek13 <= ek13;
		temp_ek21 <= ek21;
		temp_ek22 <= ek22;
		temp_ek23 <= ek23;
		temp_ek31 <= ek31;
		temp_ek32 <= ek32;
		temp_ek33 <= ek33;
		
		dk11 <= temp_dk11(3 downto 0); 
		dk12 <= temp_dk12(3 downto 0);
		dk13 <= temp_dk13(3 downto 0); 
		dk21 <= temp_dk21(3 downto 0); 
		dk22 <= temp_dk22(3 downto 0); 
		dk23 <= temp_dk23(3 downto 0);
		dk31 <= temp_dk31(3 downto 0); 
		dk32 <= temp_dk32(3 downto 0); 
		dk33 <= temp_dk33(3 downto 0); 
		
mult_inv_det : lpm_rom --ROM for determinants multiplicative inverses

GENERIC MAP(

lpm_widthad => 4, -- sets the width of the ROM address bus
lpm_numwords => 16, -- sets the words stored in the ROM
lpm_outdata => "UNREGISTERED", -- no register on the output
lpm_address_control => "REGISTERED", -- register on the input
lpm_file => "mult_inv_16.mif", -- the ascii file containing the ROM data
lpm_width => 4) -- the width of the word stored in each ROM location

PORT MAP(inclock => clk, address => det(3 downto 0), q => inv_det);

------------Assigned values to intermidiate signal to compute determinant----------------------
		cof11_2 <= cof11;
		cof12_2 <= cof12;
		cof13_2 <= cof13;
		
		ek11_2 <= temp_ek11;
		ek12_2 <= temp_ek12;
		ek13_2 <= temp_ek13;


process(clk) 

begin

if (clk'EVENT AND clk = '1') then 

	--case state is
	for i in 0 to 6 loop
		case i is
		
		when 0=>			
		
		mult1_cof11 <= temp_ek22*temp_ek33;
		mult1_cof12 <= temp_ek23*temp_ek31;
		mult1_cof13 <= temp_ek21*temp_ek32;
		mult1_cof21 <= temp_ek13*temp_ek32;
		mult1_cof22 <= temp_ek11*temp_ek33;
		mult1_cof23 <= temp_ek12*temp_ek31;
		mult1_cof31 <= temp_ek12*temp_ek23;
		mult1_cof32 <= temp_ek13*temp_ek21;
		mult1_cof33 <= temp_ek11*temp_ek22;

		when 1=>
		
		mult2_cof11 <= temp_ek23*temp_ek32;
		mult2_cof12 <= temp_ek21*temp_ek33;
		mult2_cof13 <= temp_ek22*temp_ek31;
		mult2_cof21 <= temp_ek12*temp_ek33;
		mult2_cof22 <= temp_ek13*temp_ek31;
		mult2_cof23 <= temp_ek11*temp_ek32;
		mult2_cof31 <= temp_ek22*temp_ek13;
		mult2_cof32 <= temp_ek11*temp_ek23;
		mult2_cof33 <= temp_ek12*temp_ek21;
	
		--state <= s1;
		
		when 2=>
		------------------cofactors computation------------------

		cof11 <= mult1_cof11 - mult2_cof11;
		cof12 <= mult1_cof12 - mult2_cof12;
		cof13 <= mult1_cof13 - mult2_cof13;
		cof21 <= mult1_cof21 - mult2_cof21;
		cof22 <= mult1_cof22 - mult2_cof22;
		cof23 <= mult1_cof23 - mult2_cof23;
		cof31 <= mult1_cof31 - mult2_cof31;
		cof32 <= mult1_cof32 - mult2_cof32;
		cof33 <= mult1_cof33 - mult2_cof33;
		
		
		
		--state <= s2;
		
		when 3=>
		
		------------------determinant computation-----------------
		temp_det1 <= (ek11_2*cof11_2(3 downto 0));
		temp_det2 <= (ek12_2*cof12_2(3 downto 0));
		temp_det3 <= (ek13_2*cof13_2(3 downto 0));
		
		when 4=>
		
		det <= temp_det1+temp_det2+temp_det3; 
		
		--state <= s3;
		
		when 5=>
				
		adj11 <= cof11;
		adj21 <= cof12;
		adj31 <= cof13;
		adj12 <= cof21;
		adj22 <= cof22;
		adj32 <= cof23;
		adj13 <= cof31;
		adj23 <= cof32;
		adj33 <= cof33;
		

		--state <= s4;
		
		------------------descryption key computation-------------
		when 6=>
		
		temp_dk11 <= adj11(3 downto 0) * inv_det;
		temp_dk12 <= adj12(3 downto 0) * inv_det;
		temp_dk13 <= adj13(3 downto 0) * inv_det;
		temp_dk21 <= adj21(3 downto 0) * inv_det;
		temp_dk22 <= adj22(3 downto 0) * inv_det;
		temp_dk23 <= adj23(3 downto 0) * inv_det;
		temp_dk31 <= adj31(3 downto 0) * inv_det;
		temp_dk32 <= adj32(3 downto 0) * inv_det;
		temp_dk33 <= adj33(3 downto 0) * inv_det;

		
		
		--state <= s0;
		
	end case;
end loop;

end if;

end process;



end behavior;