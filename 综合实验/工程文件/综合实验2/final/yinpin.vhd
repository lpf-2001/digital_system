library ieee;
use ieee.std_logic_1164.all;
entity yinpin is
port(clk2:in std_logic;
	output:out std_logic;
	s:in std_logic_vector(2 downto 0));
end entity;
architecture one of yinpin is
signal count0:integer:=0;
signal count1:integer:=0;
signal count2:integer:=0;
signal count3:integer:=0;
signal count4:integer:=0;
signal count5:integer:=0;
signal out1:std_logic:='0';
signal out2:std_logic:='0';
signal out3:std_logic:='0';
signal out4:std_logic:='0';
signal out5:std_logic:='0';
begin 
	process(clk2,count1)
	begin
		if(clk2'event and clk2='1')then
			if(count1=5000)then
				count1<=0;
			else 
				if(count1<2000)then
					out1<=NOT out1;
				else
					out1<='0';
				end if;
				count1<=count1+1;
			end if;
		end if;
	end process;
	process(clk2,count2)
		begin
		if(clk2'event and clk2='1')then
			if(count2=5000)then
				count2<=0;
			else 
				if(count2<2000)then
					out2<=NOT out2;
				else
					out2<='0';
				end if;
				count2<=count2+1;
			end if;
		end if;
	end process;
	process(clk2,count3)
		begin
		if(clk2'event and clk2='1')then
			if(count3=10000)then
				count3<=0;
			else 
				if(count3<2000)then
					out3<=NOT out3;
				else
					out3<='0';
				end if;
				count3<=count3+1;
			end if;
		end if;
	end process;
	process(clk2,count4)
		begin
		if(clk2'event and clk2='1')then
			if(count4=10000)then
				count4<=0;
			else 
				if(count4<2000)then
					out4<=NOT out4;
				else
					out4<='0';
				end if;
				count4<=count4+1;
			end if;
		end if;
	end process;
	process(clk2,count5)
		begin
		if(clk2'event and clk2='1')then
			if(count5=20000)then
				count5<=0;
			else 
				if(count5<2000)then
					out5<=NOT out5;
				else
					out5<='0';
				end if;
				count5<=count5+1;
			end if;
		end if;
	end process;
	process(s)
		begin
		case s is
			when "000" => output <=out5;
			when "001" => output <=out4;
			when "010" => output <=out3;
			when "011" => output <=out2;
			when "100" => output <=out1;
			when others =>NULL;
		end case;
	end process;
end one;