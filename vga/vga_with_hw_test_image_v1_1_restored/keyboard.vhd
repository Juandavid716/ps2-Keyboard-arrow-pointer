library ieee ;
use ieee.std_logic_1164.all;
-----------------------------------------------------
entity keyboard is
port(
	ps2_data    :   in std_logic;
	ps2_clock : in  std_logic;									
	size		: OUT	INTEGER ;	
   sizey		: OUT	INTEGER ;
	tamano: OUT INTEGER
);
end keyboard;
-----------------------------------------------------
architecture PS2 of keyboard is
	signal i : integer := 0;
	signal code : std_logic_vector(10 downto 0);
	SIGNAL reloj			:	INTEGER:= 0;
	signal sizeaux : integer := 20;
	signal sizeauxy : integer := 20;
	signal tamanoaux : integer := 20;
begin
    state_reg: process(ps2_clock)
    
	 begin
	 	tamano<=tamanoaux;
		sizey <= sizeauxy;
		size <=sizeaux;
		if (ps2_clock' event and ps2_clock = '0') then
			code(i)<=ps2_data;
			i<=i+1;
		
			if(i=10) then
				if(code (8 downto 1)=  X"1C" )then--A 
					
					
	            sizeaux <= sizeaux-10;
					size <= sizeaux;
				elsif (code(8 downto 1)=  X"1B") then--S
					
					sizeauxy <= sizeauxy + 10;
					sizey <= sizeauxy;
					
				elsif (code(8 downto 1)=  X"23") then--D
					
					sizeaux <=sizeaux + 10;
					size <=sizeaux;
	            		
				elsif (code(8 downto 1)=  X"24") then--E
				tamanoaux <=tamanoaux+10;
				tamano <=tamanoaux;
				elsif (code(8 downto 1)=  X"1D") then--W
				  sizeauxy <= sizeauxy - 10 ;
				  sizey <= sizeauxy ;
			 
				elsif (code(8 downto 1)=  X"15") then--Q
					if(tamanoaux>11) then
					tamanoaux <=tamanoaux-10;
				   tamano <=tamanoaux;
					end if;
				else
				
				end if;
			i<=0;
			end if;
			
	  end if;
	end process;
end PS2;

