-- nome do aluno

entity conv7seg is 
port (
signal a, b, c, d : in bit;
signal sa, sb, sc, sd, se, sf, sg : out bit
);
end entity conv7seg;



architecture logica of conv7seg is 

signal dado : bit_vector (3 downto 0);
signal display : bit_vector (6 downto 0);


begin

dado(3) <= a;
dado(2) <= b;
dado(1) <= c;
dado(0) <= d;

sg <= display(6);
sf <= display(5);
se <= display(4);
sd <= display(3);
sc <= display(2);
sb <= display(1);
sa <= display(0);

with dado select
display <= 
"0111111" when "0000",
"0000110" when "0001",
"1011011" when "0010",
"1001111" when "0011",
"1100110" when "0100",
"1101101" when "0101",
"1111101" when "0110",
"0000111" when "0111",
"1111111" when "1000",
"1101111" when "1001",
"0000000" when others;


end architecture logica;