----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:04:56 05/12/2022 
-- Design Name: 
-- Module Name:    rest_block - Behavioral 
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

entity rest_block is
	port (A, B: in STD_LOGIC_VECTOR(7 downto 0);
			s1, s2, clock, reset, ce, ce2: in STD_LOGIC;
			z_1e, z_5e, z_10e, z_20e, z_50e: in STD_LOGIC;
			ce_1e, ce_5e, ce_10e, ce_20e, ce_50e, empty: out STD_LOGIC;
			output, output2: out STD_LOGIC_VECTOR(7 downto 0));
end rest_block;

architecture Behavioral of rest_block is
component mux_n is
	generic (sel: natural; len: natural);
	port (sels: in STD_LOGIC_VECTOR(sel - 1 downto 0);
			inputs: in STD_LOGIC_VECTOR((2 ** sel) * len - 1 downto 0);
			output: out STD_LOGIC_VECTOR(len - 1 downto 0)); 
end component;
component full_subtractor_n is
	generic (n: natural);
	port (A, B: in STD_LOGIC_VECTOR(n - 1 downto 0);
			BIN: in STD_LOGIC;
			DIF: out STD_LOGIC_VECTOR(n - 1 downto 0);
			BOUT: out STD_LOGIC);
end component;
component data_register is
	generic (n: natural);
	port (d:in STD_LOGIC_VECTOR(n - 1 downto 0);
			clock, reset, ce:in STD_LOGIC;
			q:out STD_LOGIC_VECTOR(n - 1 downto 0));
end component;
component comparator is
	generic (n: natural);
	port (a,b: in STD_LOGIC_VECTOR(n - 1 downto 0);
			fmi,fme,fma: out STD_LOGIC);
end component;
component priority_encoder is
	generic (n: natural);
	port (input: in STD_LOGIC_VECTOR(2 ** n - 1 downto 0);
			output: out STD_LOGIC_VECTOR(n - 1 downto 0));
end component;
component full_adder_n is
	generic (n:natural);
	port (A, B: in STD_LOGIC_VECTOR(n - 1 downto 0);
			CIN: in STD_LOGIC;
			SUM: out STD_LOGIC_VECTOR(n - 1 downto 0);
			COUT: out STD_LOGIC);
end component;
signal muxo1, subo1, subo2, muxo2, dro, mux_o: STD_LOGIC_VECTOR(7 downto 0);
signal fma50e, fme50e, fma20e, fme20e, fma10e, fme10e, fma5e, fme5e, fma1e, fme1e, sel50e, sel20e, sel10e, sel5e, sel1e, ice_1e, ice_5e, ice_10e, ice_20e, ice_50e: STD_LOGIC;
signal pe_input, dra, fao: STD_LOGIC_VECTOR(7 downto 0);
signal pe_out: STD_LOGIC_VECTOR(2 downto 0);
signal mux_in: STD_LOGIC_VECTOR(63 downto 0);
signal muxi1, muxi2: STD_LOGIC_VECTOR(15 downto 0);
begin
	muxi1 <= "00000000" & B;
	MUX1: mux_n generic map (1, 8) port map (sels(0) => s1, inputs => muxi1, output => muxo1);
	SUB1: full_subtractor_n generic map (8) port map (A, muxo1, '0', subo1, open);
	muxi2 <= subo1 & subo2;
	MUX2: mux_n generic map (1, 8) port map (sels(0) => s2, inputs => muxi2, output => muxo2);
	DR: data_register generic map (8) port map (muxo2, clock, reset, ce, dro);
	SUB2: full_subtractor_n generic map (8) port map (dro, mux_o, '0', subo2, open);
	COMP50e: comparator generic map (8) port map (dro, "00110010", open, fme50e, fma50e);
	COMP20e: comparator generic map (8) port map (dro, "00010100", open, fme20e, fma20e);
	COMP10e: comparator generic map (8) port map (dro, "00001010", open, fme10e, fma10e);
	COMP5e: comparator generic map (8) port map (dro, "00000101", open, fme5e, fma5e);
	COMP1e: comparator generic map (8) port map (dro, "00000001", open, fme1e, fma1e);
	sel50e <= (fma50e or fme50e) and (not z_50e);
	sel20e <= (fma20e or fme20e) and (not z_20e);
	sel10e <= (fma10e or fme10e) and (not z_10e);
	sel5e <= (fma5e or fme5e) and (not z_5e);
	sel1e <= (fma1e or fme1e) and (not z_1e);
	ice_50e <= sel50e;
	ice_20e <= sel20e and (not sel50e);
	ice_10e <= (sel10e and (not sel20e)) and (not sel50e);
	ice_5e <= (sel5e and (not sel10e)) and ((not sel20e) and (not sel50e));
	ice_1e <= sel1e and (((not sel5e) and (not sel10e)) and ((not sel20e) and (not sel50e)));
	ce_50e <= ice_50e;
	ce_20e <= ice_20e;
	ce_10e <= ice_10e;
	ce_5e <= ice_5e;
	ce_1e <= ice_1e;
	pe_input <= "00" & ice_50e & ice_20e & ice_10e & ice_5e & ice_1e & "1";
	PE: priority_encoder generic map (3) port map (pe_input, pe_out);
	mux_in(63 downto 48) <= (others => '0');
	mux_in (47 downto 0) <= "00110010" & "00010100" & "00001010" & "00000101" & "00000001" & "00000000";
	MUX: mux_n generic map (3, 8) port map (pe_out, mux_in, mux_o);
	process (dro)
	variable v: STD_LOGIC;
	begin
		v := '0';
		for i in 7 downto 0 loop
			v := v or dro(i);
		end loop;
		empty <= not v;
	end process;
	output <= dro;
	FA: full_adder_n generic map (8) port map (dra, mux_o, '0', fao, open);
	DR2: data_register generic map (8) port map (fao, clock, reset, ce2, dra);
	output2 <= dra;
end Behavioral;

