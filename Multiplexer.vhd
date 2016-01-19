library ieee;
use ieee.std_logic_1164.all;

entity Multiplexer is

port( k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33: 			in std_logic_vector(3 downto 0);
		
		dk11,dk12,dk13,
		dk21,dk22,dk23,
		dk31,dk32,dk33: 		in std_logic_vector(3 downto 0);
		
		sel: 						in std_logic;
		
		out_key11,out_key12,
		out_key13,out_key21,
		out_key22,out_key23,
		out_key31,out_key32,
		out_key33: 				out std_logic_vector(3 downto 0));
		
end Multiplexer;

architecture behavior of Multiplexer is

begin

	process(sel)
		begin
			case sel is
				
				when '1' =>
				
		out_key11 <= k11;
		out_key12 <= k12;
		out_key13 <= k13;
		out_key21 <= k21;
		out_key22 <= k22;
		out_key23 <= k23;
		out_key31 <= k31;
		out_key32 <= k32;
		out_key33 <= k33;
				
				when '0' =>
					
		out_key11 <= dk11;
		out_key12 <= dk12;
		out_key13 <= dk13;
		out_key21 <= dk21;
		out_key22 <= dk22;
		out_key23 <= dk23;
		out_key31 <= dk31;
		out_key32 <= dk32;
		out_key33 <= dk33;
			
			end case;
	end process;
			
end behavior;