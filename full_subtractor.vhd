----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:09:25 05/05/2022 
-- Design Name: 
-- Module Name:    full_subtractor - Behavioral 
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

entity full_subtractor is
	port (a, b, bin: in STD_LOGIC;
			dif, bout: out STD_LOGIC);
end full_subtractor;

architecture Behavioral of full_subtractor is
begin
	process (a, b, bin)
	begin
		dif <= (a xor b) xor bin;
		bout <= ((not a) and bin) or (((not a) and b) or (b and bin));
	end process;
end Behavioral;

