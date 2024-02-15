----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:52:28 05/09/2022 
-- Design Name: 
-- Module Name:    bcd_to_7segment - Behavioral 
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

entity bcd_to_7segment is
	port (input: in STD_LOGIC_VECTOR(3 downto 0);
			output: out STD_LOGIC_VECTOR(6 downto 0));
end bcd_to_7segment;

architecture Behavioral of bcd_to_7segment is
begin
	process (input)
	begin
		case input is
			when "0000" => output <= "0000001"; -- "0"     
			 when "0001" => output <= "1001111"; -- "1" 
			 when "0010" => output <= "0010010"; -- "2" 
			 when "0011" => output <= "0000110"; -- "3" 
			 when "0100" => output <= "1001100"; -- "4" 
			 when "0101" => output <= "0100100"; -- "5" 
			 when "0110" => output <= "0100000"; -- "6" 
			 when "0111" => output <= "0001111"; -- "7" 
			 when "1000" => output <= "0000000"; -- "8"     
			 when "1001" => output <= "0000100"; -- "9"
			 when others => output <= "0000001";
		end case;
	end process;
end Behavioral;

