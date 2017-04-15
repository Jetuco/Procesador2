--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:20:07 04/11/2017
-- Design Name:   
-- Module Name:   D:/Users/Jehison/Documents/UTP/Sexto Semestre/Arquitectura de Computadores/Procesador/tb_registerfile.vhd
-- Project Name:  Procesador
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registerFile
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_registerfile IS
END tb_registerfile;
 
ARCHITECTURE behavior OF tb_registerfile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registerFile
    PORT(
         regSource1 : IN  std_logic_vector(4 downto 0);
         regSource2 : IN  std_logic_vector(4 downto 0);
         dataWrite : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         regDestino : IN  std_logic_vector(4 downto 0);
         contRegSource1 : OUT  std_logic_vector(31 downto 0);
         contRegSource2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal regSource1 : std_logic_vector(4 downto 0) := (others => '0');
   signal regSource2 : std_logic_vector(4 downto 0) := (others => '0');
   signal dataWrite : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal regDestino : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal contRegSource1 : std_logic_vector(31 downto 0);
   signal contRegSource2 : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerFile PORT MAP (
          regSource1 => regSource1,				--5
          regSource2 => regSource2,				--5
          dataWrite => dataWrite,				--32
          reset => reset,							--1
          regDestino => regDestino,				--4
          contRegSource1 => contRegSource1,	--31
          contRegSource2 => contRegSource2	--31
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		reset <= '1';
      wait for 100 ns;	
		reset <= '0';
		regSource1<="10000";
		regSource2<="10010";
		dataWrite<=X"00000011";
   end process;

END;
