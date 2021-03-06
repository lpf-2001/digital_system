library ieee;
use ieee.std_logic_1164.all;
entity n7449 is
port(din:in std_logic_vector(3 downto 0);
	dout:out std_logic_vector(6 downto 0));
end n7449;
architecture lpf of n7449 is
begin 
dout <=
"1111110"when din="0000"else
"0110000"when din="0001"else
"1101101"when din="0010"else
"1111001"when din="0011"else
"0110011"when din="0100"else
"1011011"when din="0101"else
"1011111"when din="0110"else
"1110000"when din="0111"else
"1111111"when din="1000"else
"1111011"when din="1001"else
"1110111"when din="1010"else
"0011111"when din="1011"else
"1001110"when din="1100"else
"0111101"when din="1101"else
"1001111"when din="1110"else
"1000111"when din="1111";
end architecture lpf;