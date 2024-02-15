----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:33 05/09/2022 
-- Design Name: 
-- Module Name:    segment_generator - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity segment_generator is
	port (input: in STD_LOGIC_VECTOR(7 downto 0) := "11111111";
			clock, reset: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(6 downto 0);
			anod: out STD_LOGIC_VECTOR(3 downto 0));
end segment_generator;

architecture Behavioral of segment_generator is
signal clock_out: STD_LOGIC;
component frequency_divider is
	generic (n:integer);
	port (clk,reset: in std_logic;
			clock_out: out std_logic);
end component;
component bcd_to_7segment is
	port (input: in STD_LOGIC_VECTOR(3 downto 0);
			output: out STD_LOGIC_VECTOR(6 downto 0));
end component;
component counter_n is
	generic (max_value: STD_LOGIC_VECTOR; min_value: STD_LOGIC_VECTOR);
	port (reset, clock, ce, mode, pl: in STD_LOGIC;
			d: in STD_LOGIC_VECTOR(max_value'range);
			q: out STD_LOGIC_VECTOR(max_value'range));
end component;
signal anod2: STD_LOGIC_VECTOR(1 downto 0);
signal ibcd: STD_LOGIC_VECTOR(11 downto 0);
signal aux: STD_LOGIC_VECTOR(3 downto 0);
begin
	process (input)
	variable i : integer;
	variable bcd : std_logic_vector(11 downto 0);
	variable bint : std_logic_vector(7 downto 0);
	begin
		bint := input;
		bcd := (others => '0');
		for i in 0 to 7 loop
			bcd(11 downto 1) := bcd(10 downto 0);
			bcd(0) := bint(7);
			bint(7 downto 1) := bint(6 downto 0);
			bint(0) := '0';
			if(i < 7 and bcd(3 downto 0) > "0100") then
				bcd(3 downto 0) := STD_LOGIC_VECTOR(unsigned(bcd(3 downto 0)) + "0011");
			end if;
			if(i < 7 and bcd(7 downto 4) > "0100") then
				bcd(7 downto 4) := STD_LOGIC_VECTOR(unsigned(bcd(7 downto 4)) + "0011");
			end if;
			if(i < 7 and bcd(11 downto 8) > "0100") then
				bcd(11 downto 8) := STD_LOGIC_VECTOR(unsigned(bcd(11 downto 8)) + "0011");
			end if;
		end loop;
		ibcd <= bcd;
	end process;
	U1: frequency_divider generic map (100000) port map (clk => clock, reset => reset, clock_out => clock_out);
	U2: counter_n generic map ("11", "00") port map (reset => reset, clock => clock_out, ce => '1', mode => '0', q => anod2, pl => '1', d => "00");
	D: bcd_to_7segment port map (input => aux, output => output);
	process (anod2, ibcd)
	begin
		case anod2 is
			when "00" => anod <= "1110";
							 aux <= ibcd (3 downto 0);
			when "01" => anod <= "1101";
							 aux <= ibcd (7 downto 4);
			when "10" => anod <= "1011";
							 aux <= ibcd (11 downto 8);
			when "11" => anod <= "0111";
							 aux <= "0000";
			when others => anod <= "1111";
								aux <= "0000";
		end case;
	end process;
end Behavioral;

