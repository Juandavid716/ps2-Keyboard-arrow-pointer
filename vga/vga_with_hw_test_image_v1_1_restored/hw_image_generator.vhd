--------------------------------------------------------------------------------
--
--   FileName:         hw_image_generator.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--    
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY hw_image_generator IS
	GENERIC(
		pixels_y :	INTEGER := 800;    --row that first color will persist until
		pixels_x	:	INTEGER := 600
		); 
	PORT(
		disp_ena		:	IN		STD_LOGIC;	--display enable ('1' = display time, '0' = blanking time)
		row			:	IN		INTEGER;		--row pixel coordinate
		column		:	IN		INTEGER;		--column pixel coordinate
		red			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --red magnitude output to DAC
		green			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');  --green magnitude output to DAC
		blue			:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	mouse_data		:	IN		STD_LOGIC_VECTOR(23 DOWNTO 0);
	  x			: IN	INTEGER ;	
  y			: IN	INTEGER;
  tamano : IN	INTEGER);	--blue magnitude output to DAC
END hw_image_generator;

ARCHITECTURE behavior OF hw_image_generator IS
 SIGNAL reloj			:	INTEGER:= 0;
  signal inc2 : INTEGER range 0 to 2000:=0;
   signal r : INTEGER range 0 to 1900:=0;
signal c : INTEGER range 0 to 1080:=0;
SIGNAL prueba : INTEGER; 
BEGIN
	PROCESS(disp_ena, row, column)

	BEGIN
	
		IF(disp_ena = '1') THEN		--display time
	
				inc2<=(tamano)/10;
				      
		
			IF(  row > x and row< x + tamano and column > y and column < y + tamano and ((row - x)+(column - y )< tamano)) THEN
				
			
				red <= (OTHERS => '1');
				green	<= (OTHERS => '0');
				blue <= (OTHERS => '0');
				
			ELSE
			   r<=row-x;
						c<=column-y;
			   if(row > x and row< x + tamano and column > y and column < y + tamano  and (r-c=0 or (r-c<= inc2 and r-c >= -inc2 )) )then
						
								red <= (OTHERS => '1');
							green	<= (OTHERS => '0');
							blue <= (OTHERS => '0');
				else
						red <= (OTHERS => '1');
						green	<= (OTHERS => '1');
						blue <= (OTHERS => '1');
				end if;
			END IF;
		ELSE								--blanking time
			red <= (OTHERS => '0');
			green <= (OTHERS => '0');
			blue <= (OTHERS => '0');
		END IF;
		
	END PROCESS;
END behavior;