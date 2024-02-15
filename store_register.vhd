----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:07 04/05/2022 
-- Design Name: 
-- Module Name:    store_register - Behavioral 
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

entity data_register is
	generic (n: natural);
	port (d:in STD_LOGIC_VECTOR(n - 1 downto 0);
			clock, reset, ce:in STD_LOGIC;
			q:out STD_LOGIC_VECTOR(n - 1 downto 0));
end data_register;

architecture Behavioral of data_register is
signal intern:STD_LOGIC_VECTOR(n - 1 downto 0);
begin
	process(clock, reset)
	begin
		if reset = '1' then
			intern <= (others => '0');
		elsif (clock = '1') and (clock'event) then
			if ce = '1' then
				intern <= d;
			end if;
		end if;
	end process;
	q <= intern;
end Behavioral;

