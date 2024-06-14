library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controlador_display is 
port (
signal clk, pisca1, pisca2     : in std_logic;
signal dado                    : in std_logic_vector (3 downto 0);  -- dado 0 ate F - "0000" numeros que vão aparecer no display...
signal local                   : in std_logic_vector (2 downto 0);  -- local 0 ate 7-   "000" qual display vai acender (memoria de display)...
signal tipo                    : in std_logic_vector (1 downto 0);  -- tipo 0 ate 3  -  "00" Se o display vai ficar aceso, apagado, pisca1 ou pisca2...
signal hex7, hex6, hex5, hex4,
       hex3, hex2, hex1, hex0  : out std_logic_vector (6 downto 0)  -- sinal de saida pro top level
); 
end entity controlador_display;

--================================================================================
architecture logica of controlador_display is

component conv_7seg is 
port( 
	signal dado    : in std_logic_vector (3 downto 0);
	signal en      : in std_logic;
	signal display : out std_logic_vector (6 downto 0) -- [sg sf se sd sc sb sa]
);
end component conv_7seg;


--================================================================================
-- Declarações dos sinais intermediários:
signal dadoMemoria0   : std_logic_vector (3 downto 0);
signal dadoMemoria1   : std_logic_vector (3 downto 0);
signal dadoMemoria2   : std_logic_vector (3 downto 0);
signal dadoMemoria3   : std_logic_vector (3 downto 0);
signal dadoMemoria4   : std_logic_vector (3 downto 0);
signal dadoMemoria5   : std_logic_vector (3 downto 0);
signal dadoMemoria6   : std_logic_vector (3 downto 0);
signal dadoMemoria7   : std_logic_vector (3 downto 0);

signal tipoMemoria0   : std_logic_vector (1 downto 0);
signal tipoMemoria1   : std_logic_vector (1 downto 0);
signal tipoMemoria2   : std_logic_vector (1 downto 0);
signal tipoMemoria3   : std_logic_vector (1 downto 0);
signal tipoMemoria4   : std_logic_vector (1 downto 0);
signal tipoMemoria5   : std_logic_vector (1 downto 0);
signal tipoMemoria6   : std_logic_vector (1 downto 0);
signal tipoMemoria7   : std_logic_vector (1 downto 0);

signal display        : std_logic_vector (6 downto 0);

signal en0            : std_logic                    ;
signal en1            : std_logic                    ;
signal en2            : std_logic                    ;
signal en3            : std_logic                    ;
signal en4            : std_logic                    ;
signal en5            : std_logic                    ;
signal en6            : std_logic                    ;
signal en7            : std_logic                    ;

signal slocal         : std_logic_vector (2 downto 0);

signal sclk           : std_logic                    ;
--================================================================================

begin

--================================================================================
--SALVANDO OS TIPOS DE COMPORTAMENTO DE CADA DISPLAY E SEUS RESPECTIVOS DADOS--

slocal <= local;
sclk   <= clk;

MEM : process(sclk)

begin 
	
		if sclk'event and sclk = '0' then
		
			if slocal = "000" then
				 dadoMemoria0 <= dado;
			    tipoMemoria0 <= tipo;
			end if;
			
			if slocal = "001" then
				dadoMemoria1 <= dado;
				tipoMemoria1 <= tipo;
			end if;
			
			if slocal = "010" then
				dadoMemoria2 <= dado;
				tipoMemoria2 <= tipo;
			end if;
			
			if slocal = "011" then
				dadoMemoria3 <= dado;
				tipoMemoria3 <= tipo;
			end if;
			
			if slocal = "100" then
				dadoMemoria4 <= dado;
				tipoMemoria4 <= tipo;
			end if;
			
			if slocal = "101" then
				dadoMemoria5 <= dado;
				tipoMemoria5 <= tipo;
			end if;
			
			if slocal = "110" then
				dadoMemoria6 <= dado;
				tipoMemoria6 <= tipo;
			end if;
			
			if slocal = "111" then
				dadoMemoria7 <= dado;
				tipoMemoria7 <= tipo;
			end if;
			
		end if;
					
end process MEM;

--================================================================================
--EFEITO APAGADO, ACESSO E OS TIPOS DE PISCADAS--

x1 : conv_7seg port map (dadoMemoria0, en0, hex0);

en0  <=  '1' when tipoMemoria0="01" else
         '1' when tipoMemoria0="10" and pisca1='1' else
			'1' when tipoMemoria0="11" and pisca2='1' else
			'0';
---------------------------------------------------			
x2 : conv_7seg port map (dadoMemoria1, en1, hex1);

en1  <=  '1' when tipoMemoria1="01" else
         '1' when tipoMemoria1="10" and pisca1='1' else
			'1' when tipoMemoria1="11" and pisca2='1' else
			'0';
---------------------------------------------------			
x3 : conv_7seg port map (dadoMemoria2, en2, hex2);

en2  <=  '1' when tipoMemoria2="01" else
         '1' when tipoMemoria2="10" and pisca1='1' else
			'1' when tipoMemoria2="11" and pisca2='1' else
			'0';
------------------------------------------------			
x4 : conv_7seg port map (dadoMemoria3, en3, hex3);

en3  <=  '1' when tipoMemoria3="01" else
         '1' when tipoMemoria3="10" and pisca1='1' else
			'1' when tipoMemoria3="11" and pisca2='1' else
			'0';
------------------------------------------------			
x5 : conv_7seg port map (dadoMemoria4, en4, hex4);

en4  <=  '1' when tipoMemoria4="01" else
         '1' when tipoMemoria4="10" and pisca1='1' else
			'1' when tipoMemoria4="11" and pisca2='1' else
			'0';
------------------------------------------------			
x6 : conv_7seg port map (dadoMemoria5, en5, hex5);

en5  <=  '1' when tipoMemoria5="01" else
         '1' when tipoMemoria5="10" and pisca1='1' else
			'1' when tipoMemoria5="11" and pisca2='1' else
			'0';
------------------------------------------------			
x7 : conv_7seg port map (dadoMemoria6, en6, hex6);

en6  <=  '1' when tipoMemoria6="01" else
         '1' when tipoMemoria6="10" and pisca1='1' else
			'1' when tipoMemoria6="11" and pisca2='1' else
			'0';
------------------------------------------------			
x8 : conv_7seg port map (dadoMemoria7, en7, hex7);

en7  <=  '1' when tipoMemoria7="01" else
         '1' when tipoMemoria7="10" and pisca1='1' else
			'1' when tipoMemoria7="11" and pisca2='1' else
			'0';
------------------------------------------------



end architecture logica;