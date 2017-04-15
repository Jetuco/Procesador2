----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:55:39 04/14/2017 
-- Design Name: 
-- Module Name:    conexion_procesador - arq_conexion_procesador 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conexion_procesador is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end conexion_procesador;

architecture arq_conexion_procesador of conexion_procesador is

	COMPONENT sumador
		PORT(
			operador1 : IN std_logic_vector(31 downto 0);
			operador2 : IN std_logic_vector(31 downto 0);          
			resultado : OUT std_logic_vector(31 downto 0)
			);
	END COMPONENT;
	
	COMPONENT NPC
	PORT(
		direccion : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		clk : IN std_logic;          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT instructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT unidadControl
	PORT(
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		salida : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
	COMPONENT registerFile
	PORT(
		regSource1 : IN std_logic_vector(4 downto 0);
		regSource2 : IN std_logic_vector(4 downto 0);
		dataWrite : IN std_logic_vector(31 downto 0);
		rst : IN std_logic;
		regDestino : IN std_logic_vector(4 downto 0);          
		contRegSource1 : OUT std_logic_vector(31 downto 0);
		contRegSource2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT Multiplexor
	PORT(
		dato_seu : IN std_logic_vector(31 downto 0);
		contrs2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;
		rst : IN std_logic;          
		salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT seu
	PORT(
		inmediato13bits : IN std_logic_vector(12 downto 0);
		rst : IN std_logic;          
		salidaInmediato : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT alu
	PORT(
		operando1 : IN std_logic_vector(31 downto 0);
		operando2 : IN std_logic_vector(31 downto 0);
		alu_op : IN std_logic_vector(5 downto 0);          
		salida_Alu : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	

	signal sumadorToNPC, npcTopc, pcToInstructionmemory, InstructionmemoryToURS, resultado_alu, registerfileToalu, registerfileToMultiplexor, seuToMultiplexor, multiplexorToalu: STD_LOGIC_VECTOR (31 downto 0);
	signal aluop1: STD_LOGIC_VECTOR (5 downto 0);

begin

	Inst_sumador: sumador PORT MAP(
		operador1 => X"00000001",
		operador2 => npcTopc,
		resultado => sumadorToNPC
	);
	
	Inst_NPC: NPC PORT MAP(
		direccion => sumadorToNPC,
		rst => rst,
		clk => clk,
		salida => npcTopc
	);
	
	Inst_PC: NPC PORT MAP(
		direccion => npcTopc,
		rst => rst,
		clk => clk,
		salida => pcToInstructionmemory
	);
	
	Inst_instructionMemory: instructionMemory PORT MAP(
		address => pcToInstructionmemory,
		rst => rst,
		outInstruction => InstructionmemoryToURS
	);

	Inst_unidadControl: unidadControl PORT MAP(
		op => InstructionmemoryToURS(31 downto 30),
		op3 => InstructionmemoryToURS(24 downto 19),
		salida => aluop1
	);
	
	Inst_registerFile: registerFile PORT MAP(
		regSource1 => InstructionmemoryToURS(18 downto 14),
		regSource2 => InstructionmemoryToURS(4 downto 0),
		dataWrite => resultado_alu,
		rst => rst,
		regDestino => InstructionmemoryToURS(29 downto 25),
		contRegSource1 => registerfileToalu,
		contRegSource2 => registerfileToMultiplexor
	);
	
	Inst_Multiplexor: Multiplexor PORT MAP(
		dato_seu => seuToMultiplexor,
		contrs2 => registerfileToMultiplexor,
		i => InstructionmemoryToURS(13),
		rst => rst,
		salida => multiplexorToalu
	);

	Inst_seu: seu PORT MAP(
		inmediato13bits => InstructionmemoryToURS(12 downto 0),
		rst => rst,
		salidaInmediato => seuToMultiplexor
	);
	
	Inst_alu: alu PORT MAP(
		operando1 => registerfileToalu,
		operando2 => multiplexorToalu,
		alu_op => aluop1,
		salida_Alu => resultado_alu
	);
	
	resultado <= resultado_alu;
end arq_conexion_procesador;