----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:12:41 05/14/2022 
-- Design Name: 
-- Module Name:    or_gate_n - Behavioral 
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

entity or_gate_n is
	generic (n: natural);
	port (input: in STD_LOGIC_VECTOR(n - 1 downto 0);
			output: out STD_LOGIC);
end or_gate_n;
architecture Behavioral of or_gate_n is
begin
	process (input)
	variable v: STD_LOGIC;
	begin
		v:='0';
		for i in n - 1 downto 0 loop
			v := v or input(i);
		end loop;
	output <= v;
	end process;
end Behavioral;

