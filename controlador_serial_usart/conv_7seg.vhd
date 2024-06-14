-- Gabriel Rocha Mariano da Silva
-- Prova 2


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity conv_7seg is 

port (

signal en      : in std_logic;
signal dado    : in std_logic_vector (3 downto 0);
signal display : out std_logic_vector (6 downto 0)

);

end entity conv_7seg;



architecture logica of conv_7seg is 

signal sdisplay : std_logic_vector (6 downto 0);

begin

with dado select

sdisplay <=
			"0111111" when "0000", -- 0
			"0000110" when "0001", -- 1
			"1011011" when "0010", -- 2
			"1001111" when "0011", -- 3
			"1100110" when "0100", -- 4
			"1101101" when "0101", -- 5
			"1111101" when "0110", -- 6
			"0000111" when "0111", -- 7
			"1111111" when "1000", -- 8
			"1101111" when "1001", -- 9
			"1110111" when "1010", -- A
			"1111100" when "1011", -- B
			"0111001" when "1100", -- C
			"1011110" when "1101", -- D
			"1111001" when "1110", -- E
		   "1110001" when "1111"; -- F
			
			
	habilitar_display: process(en)
	
	begin
	
		if en = '1' then	
		
			display <= sdisplay;
			
		else 
		
			display <= "0000000";
			
		end if;
		
	end process habilitar_display;
						
		

end architecture logica;