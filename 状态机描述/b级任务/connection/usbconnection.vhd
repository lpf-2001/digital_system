library ieee;
use ieee.std_logic_1164.all;
entity usbconnection is
port
(	clk:in std_logic;
	din:in std_logic_vector(7 downto 0);
	nrxf:in std_logic;
	nrd:out std_logic;
	ntxe:in std_logic;
	wr:out std_logic;
	dout:out std_logic_vector(7 downto 0));
end entity;
architecture bhv of usbconnection is
type state is(wait_nrxf_low,set_nrd_low,latch_data_from_host,wait_ntxe_low,set_wr_hign,send_data_host);
signal current_state,next_state: state;
signal temp:std_logic_vector(7 downto 0);
begin
process(clk)
begin
	if clk'event and clk='1' then
	current_state<=next_state;
	end if;
end process;
process(clk)
begin
	if clk'event and clk='1' then
	case current_state is
	when wait_nrxf_low =>
		nrd<='1';
		wr<='0';
		if nrxf='0' then 
		next_state<=set_nrd_low;
		else next_state<=wait_nrxf_low;
		end if;
	when set_nrd_low=>
		nrd<='0';
		wr<='0';
		next_state<=latch_data_from_host;
	when latch_data_from_host =>
		nrd<='0';
		wr<='0';
		temp(7 downto 0)<=din(7 downto 0);
		next_state<=wait_ntxe_low;
	when wait_ntxe_low =>
		nrd<='1';
		wr<='0';
		if ntxe='0' then 
		next_state<=set_wr_hign;
		else next_state<=wait_ntxe_low;
		end if;
	when set_wr_hign =>
		nrd<='1';
		wr<='1';
		next_state<=send_data_host;
	when send_data_host =>
		nrd<='1';
		wr<='0';
		dout(7 downto 0)<=temp(7 downto 0);
		next_state<=wait_nrxf_low;
	when others =>
		nrd<='1';
		wr<='0';
		dout<="ZZZZZZZZ";
		next_state<=wait_nrxf_low;
	end case;
end if;
end process;
end bhv;
