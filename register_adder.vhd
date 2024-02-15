----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:03:45 05/11/2022 
-- Design Name: 
-- Module Name:    register_adder - Behavioral 
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

entity register_adder is
	port (inputs: in STD_LOGIC_VECTOR(2 downto 0);
			clock, ce, reset: in STD_LOGIC;
			q: out STD_LOGIC_VECTOR(7 downto 0));
end register_adder;

architecture Behavioral of register_adder is
component mux_n is
	generic (sel: natural; len: natural);
	port (sels: in STD_LOGIC_VECTOR(sel - 1 downto 0);
			inputs: in STD_LOGIC_VECTOR((2 ** sel) * len - 1 downto 0);
			output: out STD_LOGIC_VECTOR(len - 1 downto 0)); 
	
end component;
component full_adder_n is
	generic (n:natural);
	port (A, B: in STD_LOGIC_VECTOR(n - 1 downto 0);
			CIN: in STD_LOGIC;
			SUM: out STD_LOGIC_VECTOR(n - 1 downto 0);
			COUT: out STD_LOGIC);
end component;
component data_register is
	generic (n: natural);
	port (d:in STD_LOGIC_VECTOR(n - 1 downto 0);
			clock, reset, ce:in STD_LOGIC;
			q:out STD_LOGIC_VECTOR(n - 1 downto 0));
end component;
signal inp_mux: STD_LOGIC_VECTOR(63 downto 0);
signal intern1, intern2, intern3: STD_LOGIC_VECTOR(7 downto 0);
begin
	inp_mux <= "0000000000000000000000000011001000010100000010100000010100000001";
	MUX: mux_n generic map (3, 8) port map (inputs, inp_mux, intern1);
	ADDER: full_adder_n generic map (8) port map (intern1, intern2, '0', intern3, open);
	DR: data_register generic map (8) port map (intern3, clock, reset, ce, intern2);
	q <= intern2;
end Behavioral;

