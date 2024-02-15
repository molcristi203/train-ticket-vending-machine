----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:53:50 05/11/2022 
-- Design Name: 
-- Module Name:    price_calculator - Behavioral 
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

entity price_calculator is
	port (clock, ce_sr, ce_counter, ce_dr, pl_sr, reset: in STD_LOGIC;
			d_sr: in STD_LOGIC_VECTOR(7 downto 0);
			price_calculated, empty_dest: out STD_LOGIC;
			q_dr: out STD_LOGIC_VECTOR(7 downto 0));
end price_calculator;

architecture Behavioral of price_calculator is
component shift_register is
	generic (n: natural);
	port (clock, reset, sin, ce, pl: in STD_LOGIC;
			d: in STD_LOGIC_VECTOR(n - 1 downto 0);
			q: out STD_LOGIC_VECTOR(n - 1 downto 0));
end component;
component counter_n is
	generic (max_value: STD_LOGIC_VECTOR; min_value: STD_LOGIC_VECTOR);
	port (reset, clock, ce, mode, pl: in STD_LOGIC;
			d: in STD_LOGIC_VECTOR(max_value'range);
			q: out STD_LOGIC_VECTOR(max_value'range));
end component;
component decoder is
	generic (n: natural);
	port (d: in STD_LOGIC_VECTOR(n - 1 downto 0);
			output: out STD_LOGIC_VECTOR((2 ** n) - 1 downto 0));
end component;
component comparator is
	generic (n: natural);
	port (a, b: in STD_LOGIC_VECTOR(n - 1 downto 0);
			fmi,fme,fma: out STD_LOGIC);
end component;
component mux_n is
	generic (sel: natural; len: natural);
	port (sels: in STD_LOGIC_VECTOR(sel - 1 downto 0);
			inputs: in STD_LOGIC_VECTOR((2 ** sel) * len - 1 downto 0);
			output: out STD_LOGIC_VECTOR(len - 1 downto 0)); 
end component;
component data_register is
	generic (n: natural);
	port (d: in STD_LOGIC_VECTOR(n - 1 downto 0);
			clock, reset, ce: in STD_LOGIC;
			q: out STD_LOGIC_VECTOR(n - 1 downto 0));
end component;
component or_gate_n is
	generic (n: natural);
	port (input: in STD_LOGIC_VECTOR(n - 1 downto 0);
			output: out STD_LOGIC);
end component;
signal intern1, intern3, intern4: STD_LOGIC_VECTOR(7 downto 0);
signal intern2: STD_LOGIC_VECTOR(1 downto 0);
signal fma, fme, ce_sr2, ce_dr2: STD_LOGIC;
signal input1, input2: STD_LOGIC_VECTOR(15 downto 0);
signal dec: STD_LOGIC_VECTOR(3 downto 0);
begin
	U1: shift_register generic map (8) port map (clock, reset, '0', ce_sr2, pl_sr, d_sr, intern1);
	U2: counter_n generic map ("10", "00") port map (reset, clock, ce_counter, '0', '1', "00", intern2);
	U3: decoder generic map (n => 2) port map (d => intern2, output => dec);
	COMP1: comparator generic map (8) port map (intern1, "01100100", open, open, fma);
	input1 <= "01100100" & intern1;
	MUX1: mux_n generic map (1, 8) port map (sels(0) => fma, inputs => input1, output => intern3);
	COMP2: comparator generic map (8) port map (intern3, "00000000", open, fme, open);
	input2 <= "00000001" & intern3;
	MUX2: mux_n generic map (1, 8) port map (sels(0) => fme, inputs => input2, output => intern4);
	U4: data_register generic map (8) port map (intern4, clock, reset, ce_dr2, q_dr);
	ce_sr2 <= ce_sr and dec(0);
	ce_dr2 <= ce_dr and dec(1);
	price_calculated <= dec(2);
	OG1: or_gate_n generic map (8) port map (d_sr, empty_dest);
end Behavioral;

