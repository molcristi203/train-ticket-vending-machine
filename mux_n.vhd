----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:06:30 05/04/2022 
-- Design Name: 
-- Module Name:    mux_n - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_n is
	generic (sel: natural; len: natural);
	port (sels: in STD_LOGIC_VECTOR(sel - 1 downto 0);
			inputs: in STD_LOGIC_VECTOR((2 ** sel) * len - 1 downto 0);
			output: out STD_LOGIC_VECTOR(len - 1 downto 0)); 
	
end mux_n;

architecture Behavioral of mux_n is
type slvv is array(natural range <>) of STD_LOGIC_VECTOR(len - 1 downto 0);
signal mux_in: slvv(2 ** sel - 1 downto 0);
begin
	gen: for i in 0 to 2 ** sel - 1 generate
		mux_in(i) <= inputs(((i + 1) * len) - 1 downto (i * len));
	end generate;
	output <= mux_in(to_integer(unsigned(sels)));
end Behavioral;

