-- Gabriel Ferreira e Gabriel Rocha
-- Trabalho 1

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity trabalho1 is

port(

signal KEY                     : in std_logic_vector (3 downto 0);
signal SW                      : in std_logic_vector (17 downto 0);
signal HEX7, HEX6, HEX5, HEX4, 
       HEX3, HEX2, HEX1, HEX0  : out std_logic_vector (6 downto 0)

);

end entity trabalho1;




architecture logica_trabalho1 of trabalho1 is

--=============================================================
-- componente contador 

component contador is

port(

signal botao  : in std_logic;
signal dado   : out std_logic_vector (3 downto 0)

);
end component contador;

--============================================================
--componente conversor 7 seg

component conv_7seg is 

port (

signal en      : in std_logic;
signal dado    : in std_logic_vector (3 downto 0);
signal display : out std_logic_vector (6 downto 0)

);

end component conv_7seg;
--====================================================================



--====================================================================

signal display : std_logic_vector (6 downto 0);
signal dado    : std_logic_vector (3 downto 0);
signal botao   : std_logic;
signal en      : std_logic;

-- inicio da arquitetura
begin

en <= SW(0);
botao <= KEY(3);

HEX7 <= not display;
HEX6 <= "1111111";
HEX5 <= "1111111";
HEX4 <= "1111111";
HEX3 <= "1111111";
HEX2 <= "1111111";
HEX1 <= "1111111";
HEX0 <= "1111111";

x1 : contador port map (botao, dado);
x2 : conv_7seg port map (en, dado, display);



end logica_trabalho1;
