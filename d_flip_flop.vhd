----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:53:18 05/04/2022 
-- Design Name: 
-- Module Name:    d_flip_flop - Behavioral 
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

entity d_flip_flop is
	port (reset, clock, d, ce: in STD_LOGIC;
			q, qn: out STD_LOGIC);
end d_flip_flop;

architecture Behavioral of d_flip_flop is
signal intern: STD_LOGIC;
begin
	process (clock, reset)
	begin
		if reset = '1' then
			intern <= '0';
		elsif clock = '1' and clock'event then
			if ce = '1' then
				intern <= d;
			end if;
		end if;
	end process;
	q <= intern;
	qn <= not intern;
end Behavioral;

