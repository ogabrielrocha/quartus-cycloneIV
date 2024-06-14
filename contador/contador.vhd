-- Gabriel Ferreira e Gabriel Rocha
-- Trabalho 1

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contador is

port(

signal botao    : in std_logic;
signal dado     : out std_logic_vector (3 downto 0) := "0000"

);

end entity contador;



architecture logica_contador of contador is

	begin

		contagem: process(botao)
		
			variable resultado : integer range 0 to 15 := 0;
			
				begin
				
					if botao = '0' and botao'event then -- Assim é borda de descida! subida é = '1'
						
						case resultado is
							when 0      => dado <= "0001"; resultado := 1;
							when 1      => dado <= "0010"; resultado := 2;
							when 2      => dado <= "0011"; resultado := 3;
							when 3      => dado <= "0100"; resultado := 4;
							when 4      => dado <= "0101"; resultado := 5;
							when 5      => dado <= "0110"; resultado := 6;
							when 6      => dado <= "0111"; resultado := 7;
							when 7      => dado <= "1000"; resultado := 8;
							when 8      => dado <= "1001"; resultado := 9;
							when 9      => dado <= "1010"; resultado := 10;
							when 10     => dado <= "1011"; resultado := 11;
							when 11     => dado <= "1100"; resultado := 12;
							when 12     => dado <= "1101"; resultado := 13;
							when 13     => dado <= "1110"; resultado := 14;
							when 14     => dado <= "1111"; resultado := 15;
							when 15     => dado <= "0000"; resultado := 0; 
						end case;
				
					end if;
					
					
					
			end process contagem;
							
							

end architecture logica_contador;
