----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:42:33 05/23/2022 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity command_unit is
	port (clock1, reset: in STD_LOGIC;
			state_in: in STD_LOGIC_VECTOR(15 downto 0);
			empty, empty_ticket, fmi: in STD_LOGIC;
			q_c: in STD_LOGIC_VECTOR(3 downto 0);
			q: out STD_LOGIC_VECTOR(7 downto 0);
			state_out: out STD_LOGIC_VECTOR(15 downto 0));
end command_unit;

architecture Behavioral of command_unit is
component state_block is
	port (input: in STD_LOGIC_VECTOR(15 downto 0);
			clock, reset: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(15 downto 0);
			qo: out STD_LOGIC_VECTOR(3 downto 0));
end component;
component mux_n is
	generic (sel: natural; len: natural);
	port (sels: in STD_LOGIC_VECTOR(sel - 1 downto 0);
			inputs: in STD_LOGIC_VECTOR((2 ** sel) * len - 1 downto 0);
			output: out STD_LOGIC_VECTOR(len - 1 downto 0)); 
end component;
signal iq: STD_LOGIC_VECTOR(3 downto 0);
signal mux_in: STD_LOGIC_VECTOR(47 downto 0);
signal state: STD_LOGIC_VECTOR(15 downto 0);
begin
	SB: state_block port map (state_in, clock1, reset, state, iq);
	state_out <= state;
	mux_in <= "000" & "101" & "000" & "111" & "110" & "000" & "100" & "101" & "100" & "011" & "000" & "010" & "010" & "000" & "001" & "000"; 
	DL: mux_n generic map (4, 3) port map (iq, mux_in, q(2 downto 0));
	q(7 downto 3) <= (7 => state(12), 6 => (not empty) and state(11), 5 => (not empty) and state(8), 4 => fmi and (state(7) or state(9)), 3 => not empty_ticket, others => '0');
end Behavioral;

