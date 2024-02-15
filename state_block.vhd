----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:04:52 05/10/2022 
-- Design Name: 
-- Module Name:    state_block - Behavioral 
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

entity state_block is
	port (input: in STD_LOGIC_VECTOR(15 downto 0);
			clock, reset: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(15 downto 0);
			qo: out STD_LOGIC_VECTOR(3 downto 0));
end state_block;

architecture Behavioral of state_block is
component d_flip_flop is
	port (reset, clock, d, ce: in STD_LOGIC;
			q, qn: out STD_LOGIC);
end component;
component memory is
	port (input: in STD_LOGIC_VECTOR(4 downto 0);
			output: out STD_LOGIC_VECTOR(3 downto 0));
end component;
component mux_n is
	generic (sel: natural; len: natural);
	port (sels: in STD_LOGIC_VECTOR(sel - 1 downto 0);
			inputs: in STD_LOGIC_VECTOR((2 ** sel) * len - 1 downto 0);
			output: out STD_LOGIC_VECTOR(len - 1 downto 0)); 
end component;
component decoder is
	generic (n:natural);
	port (d: in STD_LOGIC_VECTOR(n - 1 downto 0);
			output: out STD_LOGIC_VECTOR((2 ** n) - 1 downto 0));
end component;
signal q: STD_LOGIC_VECTOR(3 downto 0);
signal a: STD_LOGIC_VECTOR(4 downto 0);
signal d: STD_LOGIC_VECTOR(3 downto 0);
begin
	U1: mux_n generic map (4, 1) port map (sels => q, inputs => input, output(0) => a(4));
	M: memory port map (a, d);
	D3: d_flip_flop port map (reset => reset, clock => clock, d => d(3), q => q(3), ce => '1');
	D2: d_flip_flop port map (reset => reset, clock => clock, d => d(2), q => q(2), ce => '1');
	D1: d_flip_flop port map (reset => reset, clock => clock, d => d(1), q => q(1), ce => '1');
	D0: d_flip_flop port map (reset => reset, clock => clock, d => d(0), q => q(0), ce => '1');
	a(3 downto 0) <= q(3 downto 0);
	U2: decoder generic map (4) port map (q, output);
	qo <= q;
end Behavioral;