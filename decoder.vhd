----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:54:53 05/08/2022 
-- Design Name: 
-- Module Name:    decoder - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
	generic (n: natural);
	port (d: in STD_LOGIC_VECTOR(n - 1 downto 0);
			output: out STD_LOGIC_VECTOR((2 ** n) - 1 downto 0));
end decoder;

architecture Behavioral of decoder is
begin
	process (d)
	begin
		output <= (others => '0');
		output(to_integer(unsigned(d))) <= '1';
	end process;
end Behavioral;

