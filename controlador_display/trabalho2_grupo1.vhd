-- Trabalho realizado por:
-- Gabriel Rocha Mariano da Silva
-- Marisol Leitão dos Santos

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity trabalho2_grupo1 is
port (
signal CLOCK_50                 : in std_logic;
signal KEY                      : in std_logic_vector (3 downto 0);
signal SW                       : in std_logic_vector (7 downto 0);
signal LEDR, LEDG               : out std_logic_vector (7 downto 0);
signal HEX7, HEX6, HEX5, HEX4,
       HEX3, HEX2, HEX1, HEX0   : out std_logic_vector (6 downto 0)
);
end entity trabalho2_grupo1;

--===========================================================================
architecture logica of trabalho2_grupo1 is

--===========================================================================
--Declarando o controlador de display
component controlador_display is 
port (
signal clk, pisca1, pisca2     : in std_logic;
signal dado                    : in  std_logic_vector (3 downto 0); -- dado 0 ate F
signal local                   : in  std_logic_vector (2 downto 0); -- local 0 ate 7
signal tipo                    : in  std_logic_vector (1 downto 0); -- tipo 0 ate 3
signal hex7, hex6, hex5, hex4,
       hex3, hex2, hex1, hex0  : out std_logic_vector (6 downto 0)
);
end component controlador_display;

--===========================================================================
--Declarando o gerador de clock 
component gerador_clock is
port (
	signal clk_in         : in std_logic;
	signal pisca1, pisca2 : out std_logic
);
end component gerador_clock;

--===========================================================================
--Declarando sinais internos
signal pisca1_m : std_logic;
signal pisca2_m : std_logic;

--===========================================================================
begin

x1: controlador_display port map (

clk      => KEY(3), 
pisca1   => pisca1_m, 
pisca2   => pisca2_m,
dado(0)  =>  SW(0),
dado(1)  =>  SW(1),
dado(2)  =>  SW(2),
dado(3)  =>  SW(3),
local(0) =>  SW(4),
local(1) =>  SW(5),
local(2) =>  SW(6),
tipo(0)  =>  SW(7),
tipo(1)  =>  SW(8),
hex7     =>  HEX7, 
hex6     =>  HEX6, 
hex5     =>  HEX5, 
hex4     =>  HEX4,
hex3     =>  HEX3, 
hex2     =>  HEX2, 
hex1     =>  HEX1, 
hex0     =>  HEX0
);
									
x2: gerador_clock port map (CLOCK_50, pisca1_m, pisca2_m);

end architecture logica;