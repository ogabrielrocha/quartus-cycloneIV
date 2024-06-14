-- nome do aluno

entity controlador1 is 
port (
signal a, b, c, d : in bit;
signal disp1, disp2 : out bit_vector (6 downto 0)
);
end entity controlador1;

-- disp1 -> dezena
-- disp2 -> unidade


architecture logica of controlador1 is 

component conv7seg is 
port (
signal a, b, c, d : in bit;
signal sa, sb, sc, sd, se, sf, sg : out bit
);
end component conv7seg;

signal dd, du : bit_vector (3 downto 0);
signal dado : bit_vector (3 downto 0);

begin

dado(3) <= a;
dado(2) <= b;
dado(1) <= c;
dado(0) <= d;

x1 : conv7seg port map (dd(3), dd(2), dd(1), dd(0),
disp1(0), disp1(1), disp1(2), disp1(3), disp1(4),
disp1(5), disp1(6));

x2 : conv7seg port map (du(3), du(2), du(1), du(0),
disp2(0), disp2(1), disp2(2), disp2(3), disp2(4),
disp2(5), disp2(6));

with dado select
dd <= 
"1111" when "0000" to "1001",
"0001" when "1010" to "1111"; 

with dado select
du <= 
"0000" when "0000" | "1010",
"0001" when "0001" | "1011",
"0010" when "0010" | "1100",
"0011" when "0011" | "1101",
"0100" when "0100" | "1110",
"0101" when "0101" | "1111",
"0110" when "0110",
"0111" when "0111",
"1000" when "1000",
"1001" when "1001"; 


end architecture logica;