
-- VHDL Instantiation Created from source file Multiplexor.vhd -- 17:33:03 04/14/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT Multiplexor
	PORT(
		dato_seu : IN std_logic_vector(31 downto 0);
		contrs2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;
		rst : IN std_logic;          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	Inst_Multiplexor: Multiplexor PORT MAP(
		dato_seu => ,
		contrs2 => ,
		i => ,
		rst => ,
		salida => 
	);


