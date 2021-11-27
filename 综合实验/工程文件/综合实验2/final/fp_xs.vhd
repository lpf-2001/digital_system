library ieee;
use ieee.std_logic_1164.all;
entity fp_xs is
port (clk:in std_logic;
		clk2:out std_logic);
		end fp_xs;
architecture rtl of fp_xs is
signal count0:integer;
signal out1:std_logic;
begin
	process(clk)
		begin
			if clk'event and clk='0' then
				if count0=2500 then
					count0<=0;
					out1<=not out1;
				elsif count0<2500 then
					count0<=count0+1;
				else
					count0<=0;
				end if;
			end if;
	clk2<=out1;
	end process;
end rtl;

