library ieee;
use ieee.std_logic_1164.all;
entity addition is
port (qin:in std_logic_vector(6 downto 0);
		qout:out std_logic_vector(6 downto 0));
		end addition;
architecture rtl of addition is
begin
	process(qin)
		begin
			if(qin="0011111")then	--6
				qout<="1011111";
			elsif(qin="1110011")then	--9
				qout<="1111011";
			elsif(qin="0001101")then	--a
				qout<="1110111";
			elsif(qin="0011001")then	--b
				qout<="0011111";
			elsif(qin="0100011")then	--c
				qout<="1001110";
			elsif(qin="1001011")then	--d
				qout<="0111101";
			elsif(qin="0001111")then	--e
				qout<="1001111";
			elsif(qin="0000000")then	--f
				qout<="1000111";	
			else
				qout<=qin;
			end if;
	end process;
end rtl;






