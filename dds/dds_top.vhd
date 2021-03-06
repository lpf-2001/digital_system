library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
entity dds_top is                              -- DDS主模块          
    generic( fwords_width : integer := 20;         
              pwords_width : integer := 10);    -- 输入相位字位宽     
         
                   port(  fclk     : in std_logic;      -- DDS合成时钟  
fwords  : in std_logic_vector (19 downto 0);  
                                 -- 频率字输入 
pwords : in std_logic_vector(9 downto 0);  
                                 -- 相位字输入    
ddsout  : out std_logic_vector(7 downto 0));  
                                 -- DDS输出
end entity dds_top;

architecture arc of dds_top is
component addrreg
generic(addr_width : integer;
fadder_width : integer;
fwords_width : integer;
padder_width : integer;
pwords_width : integer);
 port(  Clk     : in std_logic; 
fwords  : in std_logic_vector (19 downto 0);
pwords : in std_logic_vector(9 downto 0);  
addressout  : out std_logic_vector(9 downto 0));  
end component;
component wave_rom
PORT
	(
		address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		inclock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);                         
end COMPONENT;
signal  wire_0 : std_logic_vector(9 downto 0);
begin
inst : addrreg
generic map(addr_width =>10,
fadder_width =>24,
fwords_width =>20,
padder_width =>10,
pwords_width =>10)
port map(Clk =>fclk , fwords => fwords , pwords => pwords , addressout => wire_0);
inst1 : wave_rom port map(address => wire_0 ,inclock=>fclk, q=>ddsout);
end arc;