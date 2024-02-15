----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:50 05/12/2022 
-- Design Name: 
-- Module Name:    cash_register - Behavioral 
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

entity cash_register is
	port (pl, clock, mode, reset: in STD_LOGIC;
			input: in STD_LOGIC_VECTOR(2 downto 0);
			ce_1e, ce_5e, ce_10e, ce_20e, ce_50e: in STD_LOGIC;
			q_1e, q_5e, q_10e, q_20e, q_50e: out STD_LOGIC_VECTOR(7 downto 0);
			output: out STD_LOGIC_VECTOR(7 downto 0);
			z_1e, z_5e, z_10e, z_20e, z_50e: out STD_LOGIC);
end cash_register;
architecture Behavioral of cash_register is
component counter_n is
	generic (max_value: STD_LOGIC_VECTOR; min_value: STD_LOGIC_VECTOR);
	port (reset, clock, ce, mode, pl: in STD_LOGIC;
			d: in STD_LOGIC_VECTOR(max_value'range);
			q: out STD_LOGIC_VECTOR(max_value'range));
end component;
component demux is
	port (sel: in STD_LOGIC_VECTOR(2 downto 0);
			input: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(7 downto 0));
end component;
signal iq_1e, iq_5e, iq_10e, iq_20e, iq_50e: STD_LOGIC_VECTOR(7 downto 0);
begin
	C1e: counter_n generic map ("11111111", "00000000") port map (reset, clock, ce_1e, mode, pl, "01100100", iq_1e);
	C5e: counter_n generic map ("11111111", "00000000") port map (reset, clock, ce_5e, mode, pl, "01100100", iq_5e);
	C10e: counter_n generic map ("11111111", "00000000") port map (reset, clock, ce_10e, mode, pl, "01100100", iq_10e);
	C20e: counter_n generic map ("11111111", "00000000") port map (reset, clock, ce_20e, mode, pl, "01100100", iq_20e);
	C50e: counter_n generic map ("11111111", "00000000") port map (reset, clock, ce_50e, mode, pl, "01100100", iq_50e);
	DMUX: demux port map (input, '1', output);
	q_1e <= iq_1e;
	q_5e <= iq_5e;
	q_10e <= iq_10e;
	q_20e <= iq_20e;
	q_50e <= iq_50e;
	process (iq_1e, iq_5e, iq_10e, iq_20e, iq_50e)
	variable v_1e, v_5e, v_10e, v_20e, v_50e: STD_LOGIC;
	begin
		v_1e := '0';
		for i in 0 to 7 loop
			v_1e := v_1e or iq_1e(i);
		end loop;
		z_1e <= not v_1e;
		
		v_5e := '0';
		for i in 0 to 7 loop
			v_5e := v_5e or iq_5e(i);
		end loop;
		z_5e <= not v_5e;
		
		v_10e := '0';
		for i in 0 to 7 loop
			v_10e := v_10e or iq_10e(i);
		end loop;
		z_10e <= not v_10e;
		
		v_20e := '0';
		for i in 0 to 7 loop
			v_20e := v_20e or iq_20e(i);
		end loop;
		z_20e <= not v_20e;
		
		v_50e := '0';
		for i in 0 to 7 loop
			v_50e := v_50e or iq_50e(i);
		end loop;
		z_50e <= not v_50e;
	end process;
end Behavioral;

