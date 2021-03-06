LIBRARY ieee;
USE ieee.std_logic_1164.all;
 
LIBRARY lpm;
USE lpm.all;
 
ENTITY wave_rom IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
		inclock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END wave_rom;
 
 
ARCHITECTURE SYN OF wave_rom IS
 
	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (7 DOWNTO 0);
 
 
 
	COMPONENT lpm_rom
	GENERIC (
		intended_device_family		: STRING;
		lpm_address_control		: STRING;
		lpm_file		: STRING;
		lpm_outdata		: STRING;
		lpm_type		: STRING;
		lpm_width		: NATURAL;
		lpm_widthad		: NATURAL
	);
	PORT (
			address	: IN STD_LOGIC_VECTOR (9 DOWNTO 0);
			inclock	: IN STD_LOGIC ;
			q	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END COMPONENT;
 
BEGIN
	q    <= sub_wire0(7 DOWNTO 0);
 
	lpm_rom_component : lpm_rom
	GENERIC MAP (
		intended_device_family => "FLEX10K",
		lpm_address_control => "REGISTERED",
		lpm_file => "triangle.mif",
		lpm_outdata => "UNREGISTERED",
		lpm_type => "LPM_ROM",
		lpm_width => 8,
		lpm_widthad => 10
	)
	PORT MAP (
		address => address,
		inclock => inclock,
		q => sub_wire0
	);
 
 
 
END SYN;
