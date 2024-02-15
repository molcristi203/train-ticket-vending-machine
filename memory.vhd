----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:07:05 05/10/2022 
-- Design Name: 
-- Module Name:    memory - Behavioral 
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

entity memory is
	port (input: in STD_LOGIC_VECTOR(4 downto 0);
			output: out STD_LOGIC_VECTOR(3 downto 0));
end memory;

architecture Behavioral of memory is
begin
	process (input)
	begin
		case input is
			when "00000" => output <= "0001";
			when "10000" => output <= "0001";
			when "00001" => output <= "0001";
			when "10001" => output <= "0010";
			when "00010" => output <= "0001";
			when "10010" => output <= "0011";
			when "00011" => output <= "0100";
			when "10011" => output <= "0001";
			when "00100" => output <= "0011";
			when "10100" => output <= "0101";
			when "00101" => output <= "0101";
			when "10101" => output <= "0110";
			when "00110" => output <= "0110";
			when "10110" => output <= "0111";
			when "00111" => output <= "1001";
			when "10111" => output <= "1000";
			when "01000" => output <= "1000";
			when "11000" => output <= "1101";
			when "01001" => output <= "0111";
			when "11001" => output <= "1110";
			when "01010" => output <= "1010";
			when "11010" => output <= "1011";
			when "01011" => output <= "1011";
			when "11011" => output <= "1100";
			when "01100" => output <= "1100";
			when "11100" => output <= "1111";
			when "01101" => output <= "1101";
			when "11101" => output <= "0001";
			when "01110" => output <= "1110";
			when "11110" => output <= "1010";
			when "01111" => output <= "0001";
			when "11111" => output <= "0001";
			when others => output <= "0000";
		end case;
	end process;
end Behavioral;

