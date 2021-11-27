library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_arith.all;

entity addrreg is                              
generic( fwords_width:integer := 20;
			pwords_width:integer := 10;
			fadder_width:integer := 24;
			padder_width:integer := 10;
			addr_width:integer := 10);
     port( Clk     : in std_logic;      -- DDS�ϳ�ʱ��  
fwords  : in std_logic_vector (fwords_width-1 downto 0);  
                                 -- Ƶ�������� 
pwords : in std_logic_vector(pwords_width-1 downto 0);  
                                 -- ��λ������    
	addressout  : out std_logic_vector(addr_width-1 downto 0));  
									 
	end addrreg;

	architecture rtl of addrreg is
	signal fwords_reg  : std_logic_vector (fwords_width-1 downto 0);  
	signal pwords_reg  : std_logic_vector (pwords_width-1 downto 0);  
signal fadder_out  : std_logic_vector (fadder_width-1 downto 0);  
signal padder_out  : std_logic_vector (padder_width-1 downto 0);  

begin
    process (Clk,fwords,pwords)
    begin
        if(Clk'event and clk = '1') then
            fwords_reg <= fwords;    -- Ƶ��������ͬ��
            pwords_reg <= pwords;  -- ��λ������ͬ��
            fadder_out <= fadder_out + fwords_reg; -- ��λ�ۼ���
        end if;
    end process;
padder_out <= fadder_out(fadder_width-1 downto fadder_width-pwords_width) + pwords_reg; 
   addressout <= padder_out;
   end rtl;