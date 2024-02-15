----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:54:14 04/06/2022 
-- Design Name: 
-- Module Name:    shift_register - Behavioral 
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

entity shift_register is
	generic (n: natural);
	port( clock, reset, sin, ce, pl: in STD_LOGIC;
			d: in STD_LOGIC_VECTOR(n - 1 downto 0);
			q: out STD_LOGIC_VECTOR(n - 1 downto 0));
end shift_register;

architecture Behavioral of shift_register is
signal intern: STD_LOGIC_VECTOR(n - 1 downto 0);
begin
	process(clock, reset, pl, d)
	begin
		if reset = '1' then
			intern <= (others => '0');
		elsif pl = '0' then
			intern <= d;
		elsif (clock = '1') and (clock'event) then
			if ce = '1' then
				intern(n - 1 downto 0) <= sin & intern(n - 1 downto 1);
			end if;
		end if;
	end process;
	q <= intern;
end Behavioral;

