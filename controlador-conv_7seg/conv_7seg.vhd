library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity conv_7seg is 
port(
	signal dado    : in std_logic_vector (3 downto 0);
	signal en      : in bit;
	signal display : out std_logic_vector (6 downto 0) -- [sg sf se sd sc sb sa]
);
end entity conv_7seg;

architecture c_conv_7seg of conv_7seg is

signal sdisplay : std_logic_vector (6 downto 0);

begin

display <= sdisplay when en='1' else "1111111";
        
with dado select
sdisplay <= 
				"1000000" when "0000", -- 0  0111111   
				"1111001" when "0001", -- 1  0000110   
				"0100100" when "0010", -- 2  1011011   
				"0110000" when "0011", -- 3  1001111   
				"0011001" when "0100", -- 4  1100110   
				"0010010" when "0101", -- 5  1101101   
				"0000010" when "0110", -- 6  1111101   
				"1111000" when "0111", -- 7  0000111   
				"0000000" when "1000", -- 8  1111111   
				"0010000" when "1001", -- 9  1101111   
				"0001000" when "1010", -- A  1110111   
				"0000011" when "1011", -- b  1111100   
				"1000110" when "1100", -- C  0111001   
				"0100001" when "1101", -- d  1011110   
				"0000110" when "1110", -- E  1111001   
				"0001110" when "1111"; -- F  1110001   

end architecture c_conv_7seg;