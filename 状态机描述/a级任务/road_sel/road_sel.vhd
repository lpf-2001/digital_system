library ieee;
use ieee.std_logic_1164.all;
entity road_sel is
	port(
			wr,nrd:in std_logic;
			sel:out std_logic
			);
end entity;
architecture bhv of road_sel is
begin
	process(wr)
	begin
		if wr='1' then
				sel<='1';
		elsif nrd='0' then
		sel<='0';
		else
		sel<='1';
		end if;
	end process;
end bhv;