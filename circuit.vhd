----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:18:19 05/24/2022 
-- Design Name: 
-- Module Name:    circuit2 - Behavioral 
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

entity circuit is
	port (input: in STD_LOGIC_VECTOR(7 downto 0);
			enter_btn, start_btn, reset_btn, cancel_btn, clock: in STD_LOGIC;
			catod: out STD_LOGIC_VECTOR(6 downto 0);
			q: out STD_LOGIC_VECTOR(7 downto 0);
			anod: out STD_LOGIC_VECTOR(3 downto 0));
end circuit;

architecture Structural of circuit is
component command_unit is
	port (clock1, reset: in STD_LOGIC;
			state_in: in STD_LOGIC_VECTOR(15 downto 0);
			empty, empty_ticket, fmi: in STD_LOGIC;
			q_c: in STD_LOGIC_VECTOR(3 downto 0);
			q: out STD_LOGIC_VECTOR(7 downto 0);
			state_out: out STD_LOGIC_VECTOR(15 downto 0));
end component;
component debouncer is
	port (input, clock, reset: in STD_LOGIC;
			output: out STD_LOGIC);
end component;
component segment_generator is
	port (input: in STD_LOGIC_VECTOR(7 downto 0) := "11111111";
			clock, reset: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(6 downto 0);
			anod: out STD_LOGIC_VECTOR(3 downto 0));
end component;
component frequency_divider is
	generic (n: integer);
	port (clk,reset: in std_logic;
			clock_out: out std_logic);
end component;
component execution_unit is
	port (state_in: in STD_LOGIC_VECTOR(15 downto 0);
			start_btn, cancel_btn, enter_btn, reset_btn, clock1, clock2: in STD_LOGIC;
			input: in STD_LOGIC_VECTOR(7 downto 0);
			segment_out: out STD_LOGIC_VECTOR(7 downto 0);
			empty_out, empty_ticket, fmi: out STD_LOGIC;
			state_out: out STD_LOGIC_VECTOR(15 downto 0);
			q_c: out STD_LOGIC_VECTOR(3 downto 0));
end component;
signal istart, ienter, icancel, ireset, clock1, clock2, empty_out, empty_tkt, fmi: STD_LOGIC;
signal state1, state2: STD_LOGIC_VECTOR(15 downto 0);
signal isg: STD_LOGIC_VECTOR(7 downto 0);
signal q_c: STD_LOGIC_VECTOR(3 downto 0);
begin
	FD1: frequency_divider generic map (25000) port map (clock, reset_btn, clock1);
	FD2: frequency_divider generic map (50000000) port map (clock, reset_btn, clock2);
	DR: debouncer port map(reset_btn, clock1, reset_btn, ireset);
	DE: debouncer port map(enter_btn, clock1, reset_btn, ienter);
	DS: debouncer port map(start_btn, clock1, reset_btn, istart);
	DC: debouncer port map(cancel_btn, clock1, reset_btn, icancel);
	CU: command_unit port map (clock1, reset_btn, state1, empty_out, empty_tkt, fmi, q_c, q, state2);
	SG: segment_generator port map (isg, clock, reset_btn, catod, anod);
	EU: execution_unit port map (state2, istart, icancel, ienter, ireset, clock1, clock2, input, isg, empty_out, empty_tkt, fmi, state1, q_c);
end Structural;