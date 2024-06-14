
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity gerador_clock is
port (
	signal clk_in : in std_logic;
	signal pisca1, pisca2 : out std_logic
);
end entity gerador_clock;

-----------------------------------------------------------------------------

architecture c_gerador_clock of gerador_clock is

signal clk_1m, sclk_out1, sclk_out2 : std_logic;

------------------------------------------------------------------------------

begin

pisca1 <= sclk_out1;
pisca2 <= sclk_out2;

----------------------------------------------------------------------------------
p_clk_1m: process(clk_in)

variable contador : integer range 0 to 25000 := 0;

begin

	if clk_in='0' and clk_in'event then
	
		if contador < 24999 then
			contador := contador + 1;
		else
			contador := 0;
			clk_1m <= not clk_1m;
		end if;
	
	end if;
end process p_clk_1m;

----------------------------------------------------------------------------------

p_clk_out1: process(clk_1m)

variable contador : integer range 0 to 300 := 0;

begin

	if clk_1m='0' and clk_1m'event then
	
		if contador < 299 then
			contador := contador + 1;
		else
			contador := 0;
			sclk_out1 <= not sclk_out1;
		end if;
	
	end if;
end process p_clk_out1;

---------------------------------------------------------------------------------------

p_clk_out2: process(clk_1m)

variable contador : integer range 0 to 600 := 0;

begin

	if clk_1m='0' and clk_1m'event then
	
		if contador < 599 then
			contador := contador + 1;
		else
			contador := 0;
			sclk_out2 <= not sclk_out2;
		end if;
		
	end if;
end process p_clk_out2;

----------------------------------------------------------------------------------------------

end architecture c_gerador_clock;
