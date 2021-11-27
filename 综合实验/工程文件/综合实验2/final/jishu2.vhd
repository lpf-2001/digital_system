library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity jishu2 is
	port(clk,clr,echo:in std_logic;
		 t:out std_logic_vector(15 downto 0));
end jishu2;

architecture arch of jishu2 is
signal j:std_logic_vector(15 downto 0):="0000000000000000";

begin
	process(clk,clr,echo)
	begin
	if(clr='1') then
		j<="0000000000000000";
	elsif(j="1111111111111111") then
		j<="0000000000000000";
	elsif(clk'event and clk='1') then
		if(echo='1') then
			j<=j+1;
		else  t<=j;
		end if;
	end if;
end process;
end arch;