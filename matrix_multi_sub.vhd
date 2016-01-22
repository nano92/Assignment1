----------------------------------------------------------------------
-- File name: matrix_multi_sub.vhd
-- Author: Luis Gallet Zambrano - 260583750
-- Creation date: 01/11/16
-- Last revision date: 01/12/16
 
-- Description: Sub module of the structural matrix multiplier 
-- description. It uses lpm_ADD_SUB and lpm_MULT components 
-- for each multiplication (3) and for each addition (2), in modulo-16
----------------------------------------------------------------------

library altera_mf;
library lpm;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use lpm.lpm_components.all;

entity matrix_multi_sub is

port(	p1,p2,p3,
		k1X,k2X,k3X: in std_logic_vector(3 downto 0);
		
		cX:    		out std_logic_vector(3 downto 0));

end matrix_multi_sub;

architecture behavior of matrix_multi_sub is

signal temp_mult1,temp_mult2,temp_mult3: std_logic_vector(7 downto 0);-- temp output signal for lpm_mult for c1

signal temp_add1,temp_add2: std_logic_vector(7 downto 0);-- temp output signal for lpm_add for c1


signal temp_cX: std_logic_vector(7 downto 0); -- temp output signals



begin


---------------Multiplier sub module-----------------------
C1_muilt1 : LPM_MULT

 GENERIC MAP ( 
 LPM_WIDTHA => 4, --width of dataA port
 LPM_WIDTHB => 4, --width of dataB port
 LPM_WIDTHP => 8, --width of the result port
 LPM_TYPE => "L_MULT"
)

PORT MAP ( DATAA => p1,
		 DATAB => k1X,
		 RESULT => temp_mult1
);

CX_muilt2 : LPM_MULT

 GENERIC MAP ( 
 LPM_WIDTHA => 4, --width of dataA port
 LPM_WIDTHB => 4, --width of dataB port
 LPM_WIDTHP => 8, --width of the result port
 LPM_TYPE => "L_MULT"
)

PORT MAP ( DATAA => p2,
		 DATAB => k2X,
		 RESULT => temp_mult2
);

CX_muilt3 : LPM_MULT

 GENERIC MAP ( 
 LPM_WIDTHA => 4, --width of dataA port
 LPM_WIDTHB => 4, --width of dataB port
 LPM_WIDTHP => 8, --width of the result port
 LPM_TYPE => "L_MULT"
)

PORT MAP ( DATAA => p3,
		 DATAB => k3X,
		 RESULT => temp_mult3
);

----------------Add sub module-------------------------------
cX_add1 : LPM_ADD_SUB
 
 GENERIC MAP (
LPM_WIDTH => 8, --multiplication of two 4-bit inputs gets 8-bit result
LPM_TYPE => "L_ADD_SUB"
)

PORT MAP (DATAA => temp_mult1,
		DATAB => temp_mult2,
		RESULT => temp_add1
);

cX_add2 : LPM_ADD_SUB
 
 GENERIC MAP (
LPM_WIDTH => 8, --multiplication of two 4-bit inputs gets 8-bit result
LPM_TYPE => "L_ADD_SUB"
)
PORT MAP (DATAA => temp_add1,
		DATAB => temp_mult3,
		RESULT => temp_cX
);

cX <= temp_cX(3 downto 0); --only the 4-least significant bits are useful







end behavior;