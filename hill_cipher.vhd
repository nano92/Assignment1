library ieee;
use ieee.std_logic_1164.all;


entity hill_cipher is

port(	p1,p2,p3: 	in std_logic_vector(3 downto 0);
		clk: 			in std_logic;
		load_key:	in std_logic;
		encrypt:		in std_logic;
		
		c1,c2,c3:   out std_logic_vector(3 downto 0));
		
end hill_cipher;

architecture behavior of hill_cipher is


component key_loader is

port(	p1,p2,p3   : in std_logic_vector(3 downto 0);
		clk 		 	: in std_logic;
		load_key    : in std_logic;

		k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33 : out std_logic_vector(3 downto 0));

end component;



component key_inverter is

port( ek11,ek12,ek13,
		ek21,ek22,ek23,
		ek31,ek32,ek33: in std_logic_vector(3 downto 0);
		
		clk: in std_logic;
		
		dk11,dk12,dk13,
		dk21,dk22,dk23,
		dk31,dk32,dk33: out std_logic_vector(3 downto 0));
		
end component;



component Multiplexer is

port( k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33: 			in std_logic_vector(3 downto 0);
		
		dk11,dk12,dk13,
		dk21,dk22,dk23,
		dk31,dk32,dk33: 		in std_logic_vector(3 downto 0);
		
		sel: 						in std_logic;
		
		clk:						in std_logic;
		
		out_key11,out_key12,
		out_key13,out_key21,
		out_key22,out_key23,
		out_key31,out_key32,
		out_key33: 				out std_logic_vector(3 downto 0));
		
end component;


component matrix_multi is

port(	p1,p2,p3,
		k11,k12,k13,
		k21,k22,k23,
		k31,k32,k33: in std_logic_vector(3 downto 0);
		
		clk: 			 in std_logic;
		c1,c2,c3:    out std_logic_vector(3 downto 0));

end component;


component D_FF is

port
   (
      clk : in std_logic;

		--enable : in std_logic := '1';
      
      d : in std_logic;

      q : out std_logic);

end component;

signal temp_k11,temp_k12,temp_k13,
		 temp_k21,temp_k22,temp_k23,
		 temp_k31,temp_k32,temp_k33:    std_logic_vector(3 downto 0);

signal temp_dk11,temp_dk12,temp_dk13,
		 temp_dk21,temp_dk22,temp_dk23,
		 temp_dk31,temp_dk32,temp_dk33: std_logic_vector(3 downto 0);

signal temp_out_key11,temp_out_key12,
		 temp_out_key13,temp_out_key21,
		 temp_out_key22,temp_out_key23,
		 temp_out_key31,temp_out_key32,
		 temp_out_key33: 						  std_logic_vector(3 downto 0);

signal reg_encrypt: std_logic;


begin

LOADER: key_loader 

port map(
				p1=>p1, 
				p2=>p2, 
				p3=>p3, 
				
				clk=>clk,
			   
				load_key=>load_key,
				
				k11=>temp_k11,
				k12=>temp_k12,
				k13=>temp_k13,
				k21=>temp_k21,
				k22=>temp_k22,
				k23=>temp_k23,
				k31=>temp_k31,
				k32=>temp_k32,
				k33=>temp_k33
				
			);
				
INVERTER: key_inverter

port map( 
				ek11=>temp_k11,
				ek12=>temp_k12,
				ek13=>temp_k13,
				ek21=>temp_k21,
				ek22=>temp_k22,
				ek23=>temp_k23,
				ek31=>temp_k31,
				ek32=>temp_k32,
				ek33=>temp_k33,
				
				clk=>clk,
				
				dk11=>temp_dk11,
				dk12=>temp_dk12,
				dk13=>temp_dk13,
				dk21=>temp_dk21,
				dk22=>temp_dk22,
				dk23=>temp_dk23,
				dk31=>temp_dk31,
				dk32=>temp_dk32,
				dk33=>temp_dk33
			
			);
			

ENCRYPT_FF : D_FF

port map (
				d=>encrypt,
				clk=>clk,
				q=>reg_encrypt
			); 



MULTI: Multiplexer

port map( 
				k11=>temp_k11,
				k12=>temp_k12,
				k13=>temp_k13,
				k21=>temp_k21,
				k22=>temp_k22,
				k23=>temp_k23,
				k31=>temp_k31,
				k32=>temp_k32,
				k33=>temp_k33,
				
				dk11=>temp_dk11,
				dk12=>temp_dk12,
				dk13=>temp_dk13,
				dk21=>temp_dk21,
				dk22=>temp_dk22,
				dk23=>temp_dk23,
				dk31=>temp_dk31,
				dk32=>temp_dk32,
				dk33=>temp_dk33,
				
				sel=>reg_encrypt,
				
				clk=>clk,
		
				out_key11=>temp_out_key11,
				out_key12=>temp_out_key12,
				out_key13=>temp_out_key13,
				out_key21=>temp_out_key21,
				out_key22=>temp_out_key22,
				out_key23=>temp_out_key23,
				out_key31=>temp_out_key31,
				out_key32=>temp_out_key32,
				out_key33=>temp_out_key33	
	
			);
			
MATRIX_MULTIPLIER: matrix_multi

port map(	
				p1=>p1, 
				p2=>p2, 
				p3=>p3,
				
				k11=>temp_out_key11,
				k12=>temp_out_key12,
				k13=>temp_out_key13,
				k21=>temp_out_key21,
				k22=>temp_out_key22,
				k23=>temp_out_key23,
				k31=>temp_out_key31,
				k32=>temp_out_key32,
				k33=>temp_out_key33,	
				
				clk=>clk,
				
				c1=>c1,
				c2=>c2,
				c3=>c3
		
			);

end behavior;