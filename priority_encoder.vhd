----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:03:12 05/21/2022 
-- Design Name: 
-- Module Name:    priority_encoder - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity priority_encoder is
	generic (n: natural);
	port (input: in STD_LOGIC_VECTOR(2 ** n - 1 downto 0);
			output: out STD_LOGIC_VECTOR(n - 1 downto 0));
end priority_encoder;

architecture Behavioral of priority_encoder is
begin
	process (input)
	variable v: STD_LOGIC_VECTOR(n - 1 downto 0);
	begin
		v:=(others => 'Z');
		for i in 0 to 2 ** n - 1 loop
			if input(i) = '1' then
				v := STD_LOGIC_VECTOR(to_unsigned(i, v'length));
			end if;
		end loop;
		output <= v;
	end process;
end Behavioral;

