library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity jingbao is
	port(a:in integer range 0 to 65527;
		 q:out std_logic_vector(2 downto 0));
end jingbao;

architecture cc of jingbao is
begin
process(a)
	begin
		if(a>0) and (a<=20) then q<="100";
		elsif(a>20) and (a<=60) then q<="011";
		elsif(a>60) and (a<=100) then q<="010";
		elsif(a>100) and (a<=150) then q<="001";
		else q<="000";
		end if;
	end process;
end cc;