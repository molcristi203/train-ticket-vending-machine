----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:32:25 05/12/2022 
-- Design Name: 
-- Module Name:    demux - Behavioral 
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

entity demux is
	port (sel: in STD_LOGIC_VECTOR(2 downto 0);
			input: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(7 downto 0));
end demux;

architecture Behavioral of demux is
	
begin
	process (sel, input)
	variable intern: STD_LOGIC_VECTOR(7 downto 0);
	begin
		case sel is
			when "000" => intern:=(0 => input, others => '0');
			when "001" => intern:=(1 => input, others => '0');
			when "010" => intern:=(2 => input, others => '0');
			when "011" => intern:=(3 => input, others => '0');
			when "100" => intern:=(4 => input, others => '0');
			when "101" => intern:=(5 => input, others => '0');
			when "110" => intern:=(6 => input, others => '0');
			when "111" => intern:=(7 => input, others => '0');
			when others => intern:=(others => '0');
		end case;
		output <= intern;
	end process;
end Behavioral;

