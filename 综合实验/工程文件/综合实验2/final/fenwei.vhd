library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity fenwei is
port(cin:in std_logic_vector(15 downto 0);
	dout0,dout1,dout2:out std_logic_vector(3 downto 0));
end  fenwei;
architecture rtl of fenwei is
signal cin_Reg:std_logic_vector(15 downto 0);
signal dout_Reg:integer range 0 to 999;
signal bb,ss,gg:integer range 0 to 9;
signal b_Reg,s_Reg,g_Reg:std_logic_vector(3 downto 0);
begin
	process(cin_Reg)
	begin
		if(cin>"0000001111100111")then
			cin_Reg<="0000001111100111";
		else
			cin_Reg<=cin;
		end if;
	end process;
	dout_Reg<=conv_integer(cin_Reg);
	bb<=dout_Reg/100;
	ss<=(dout_Reg-bb*100)/10;
	gg<=(dout_Reg-bb*100-ss*10);
	b_Reg<=conv_std_logic_vector(bb,4);
	s_Reg<=conv_std_logic_vector(ss,4);
	g_Reg<=conv_std_logic_vector(gg,4);
	dout0<=b_Reg;
	dout1<=s_Reg;
	dout2<=g_Reg;
end rtl;