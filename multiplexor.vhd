----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:49:56 04/11/2017 
-- Design Name: 
-- Module Name:    Multiplexor - arq_Multiplexor 
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

entity Multiplexor is
    Port ( dato_seu : in  STD_LOGIC_VECTOR (31 downto 0);
           contrs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
           salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Multiplexor;

architecture arq_Multiplexor of Multiplexor is

begin
	process(i,dato_seu,contrs2)
	begin
		if(i='1')then
			salida<= dato_seu;
		else 
			if(i='0')then
				salida <= contrs2;
			end if ; 
		end if; 	
	end process; 

end arq_Multiplexor;