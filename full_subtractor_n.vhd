----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:28:21 05/05/2022 
-- Design Name: 
-- Module Name:    full_subtractor_n - Behavioral 
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

entity full_subtractor_n is
	generic (n: natural);
	port (A, B: in STD_LOGIC_VECTOR(n - 1 downto 0);
			BIN: in STD_LOGIC;
			DIF: out STD_LOGIC_VECTOR(n - 1 downto 0);
			BOUT: out STD_LOGIC);
end full_subtractor_n;

architecture Behavioral of full_subtractor_n is
component full_subtractor is
	port (a, b, bin: in STD_LOGIC;
			dif, bout: out STD_LOGIC);
end component;
signal intern: STD_LOGIC_VECTOR(n - 2 downto 0);
begin
	L1: for i in 0 to n - 1 generate
		L2: if i = 0 generate
			L3: full_subtractor port map (A(i), B(i), BIN, DIF(i), intern(i));
		end generate;
		L4: if (i > 0) and (i < n - 1) generate
			L5: full_subtractor port map (A(i), B(i), intern(i - 1), DIF(i), intern(i));
		end generate;
		L6: if i = n - 1 generate
			L7: full_subtractor port map (A(i), B(i), intern(i - 1), DIF(i), BOUT);
		end generate;
	end generate;
end Behavioral;

