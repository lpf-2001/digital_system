library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
entity distance is
port(data:in std_logic_vector(15 downto 0);
	qout:buffer std_logic_vector(15 downto 0));
end distance;
architecture rtl of distance is
signal tn:integer;
signal ans:integer;
signal ansl:integer;
begin
process(tn,ans,qout)
	begin
	tn<= conv_integer(data);
	ans<=85*(tn)/10;
	qout<=conv_std_logic_vector(ans,16);
end process;
end rtl;