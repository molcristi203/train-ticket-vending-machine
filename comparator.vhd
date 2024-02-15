----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:27:08 04/06/2022 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

entity comparator is
	generic (n: natural);
	port (a,b: in STD_LOGIC_VECTOR(n - 1 downto 0);
			fmi,fme,fma: out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is
begin
	process(a,b)
	begin
		if a > b then
			fmi <= '0';
			fme <= '0';
			fma <= '1';
		elsif a = b then 
			fmi <= '0';
			fme <= '1';
			fma <= '0';
		else
			fmi <= '1';
			fme <= '0';
			fma <= '0';
		end if;
	end process;
end Behavioral;

