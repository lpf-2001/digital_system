library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity voice is
port(kz:in std_logic_vector(2 downto 0);
	clk:in std_logic;
	q:out std_logic:='1');
end voice;
architecture y115 of voice is
signal count:std_logic_vector(2 downto 0):="000";
begin
process(kz,clk,count)
	begin
	if(clk'event and clk='1')then
		count<=count+1;
		if(kz="000"and count="100")then
			q<='0';
		elsif(kz="001"and count="011")then
			q<='0';
		elsif(kz="010"and count="010")then
			q<='0';
		elsif(kz="011"and count="001")then
			q<='0';
		elsif(kz="100"and count="000")then
			q<='0';
		end if;
	end if;
end process;
end y115;