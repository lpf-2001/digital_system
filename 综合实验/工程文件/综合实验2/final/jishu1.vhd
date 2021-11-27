library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity jishu1 is
	port(clk:in std_logic;
		 trig,clr:out std_logic);
end entity jishu1;
architecture arch of jishu1 is
signal j:std_logic_vector(15 downto 0):="1111111111111111";

begin 
	process(clk)
	begin
	if(j="1111111111111111") then
		trig<='1'; clr<='1'; j<="0000000000000000";
	elsif(clk'event and clk='1') then
		j<=j+1; clr<='0';
		if(j="0000000000011111") then
			trig<='0';		--trig  gui 0
		end if;
	end if;
end process;
end arch;