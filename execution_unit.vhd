----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:41:02 05/23/2022 
-- Design Name: 
-- Module Name:    execution_unit - Behavioral 
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

entity execution_unit is
	port (state_in: in STD_LOGIC_VECTOR(15 downto 0);
			start_btn, cancel_btn, enter_btn, reset_btn, clock1, clock2: in STD_LOGIC;
			input: in STD_LOGIC_VECTOR(7 downto 0);
			segment_out: out STD_LOGIC_VECTOR(7 downto 0);
			empty_out, empty_ticket, fmi: out STD_LOGIC;
			state_out: out STD_LOGIC_VECTOR(15 downto 0);
			q_c: out STD_LOGIC_VECTOR(3 downto 0));
end execution_unit;

architecture Behavioral of execution_unit is
component state_block is
	port (input: in STD_LOGIC_VECTOR(15 downto 0);
			clock, reset: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(15 downto 0);
			qo: out STD_LOGIC_VECTOR(3 downto 0));
end component;
component frequency_divider is
	generic (n: integer);
	port (clk,reset: in std_logic;
			clock_out: out std_logic);
end component;
component price_calculator is
	port (clock, ce_sr, ce_counter, ce_dr, pl_sr, reset: in STD_LOGIC;
			d_sr: in STD_LOGIC_VECTOR(7 downto 0);
			price_calculated, empty_dest: out STD_LOGIC;
			q_dr: out STD_LOGIC_VECTOR(7 downto 0));
end component;
component register_adder is
	port (inputs: in STD_LOGIC_VECTOR(2 downto 0);
			clock, ce, reset: in STD_LOGIC;
			q: out STD_LOGIC_VECTOR(7 downto 0));
end component;
component comparator is
	generic (n: natural);
	port (a,b: in STD_LOGIC_VECTOR(n - 1 downto 0);
			fmi,fme,fma: out STD_LOGIC);
end component;
component segment_generator is
	port (input: in STD_LOGIC_VECTOR(7 downto 0) := "11111111";
			clock, reset: in STD_LOGIC;
			output: out STD_LOGIC_VECTOR(6 downto 0);
			anod: out STD_LOGIC_VECTOR(3 downto 0));
end component;
component full_subtractor_n is
	generic (n: natural);
	port (A, B: in STD_LOGIC_VECTOR(n - 1 downto 0);
			BIN: in STD_LOGIC;
			DIF: out STD_LOGIC_VECTOR(n - 1 downto 0);
			BOUT: out STD_LOGIC);
end component;
component counter_n is
	generic (max_value: STD_LOGIC_VECTOR; min_value: STD_LOGIC_VECTOR);
	port (reset, clock, ce, mode, pl: in STD_LOGIC;
			d: in STD_LOGIC_VECTOR(max_value'range);
			q: out STD_LOGIC_VECTOR(max_value'range));
end component;
component  decoder is
	generic (n: natural);
	port (d: in STD_LOGIC_VECTOR(n - 1 downto 0);
			output: out STD_LOGIC_VECTOR((2 ** n) - 1 downto 0));
end component;
component debouncer is
	port (input, clock, reset: in STD_LOGIC;
			output: out STD_LOGIC);
end component;
component priority_encoder is
	generic (n: natural);
	port (input: in STD_LOGIC_VECTOR(2 ** n - 1 downto 0);
			output: out STD_LOGIC_VECTOR(n - 1 downto 0));
end component;
component mux_n is
	generic (sel: natural; len: natural);
	port (sels: in STD_LOGIC_VECTOR(sel - 1 downto 0);
			inputs: in STD_LOGIC_VECTOR((2 ** sel) * len - 1 downto 0);
			output: out STD_LOGIC_VECTOR(len - 1 downto 0)); 
end component;
component cash_register is
	port (pl, clock, mode, reset: in STD_LOGIC;
			input: in STD_LOGIC_VECTOR(2 downto 0);
			ce_1e, ce_5e, ce_10e, ce_20e, ce_50e: in STD_LOGIC;
			q_1e, q_5e, q_10e, q_20e, q_50e: out STD_LOGIC_VECTOR(7 downto 0);
			output: out STD_LOGIC_VECTOR(7 downto 0);
			z_1e, z_5e, z_10e, z_20e, z_50e: out STD_LOGIC);
end component;
component rest_block is
	port (A, B: in STD_LOGIC_VECTOR(7 downto 0);
			s1, s2, clock, reset, ce, ce2: in STD_LOGIC;
			z_1e, z_5e, z_10e, z_20e, z_50e: in STD_LOGIC;
			ce_1e, ce_5e, ce_10e, ce_20e, ce_50e, empty: out STD_LOGIC;
			output, output2: out STD_LOGIC_VECTOR(7 downto 0));
end component;
component or_gate_n is
	generic (n: natural);
	port (input: in STD_LOGIC_VECTOR(n - 1 downto 0);
			output: out STD_LOGIC);
end component;
signal state_output, decod, decod2, decod3, decod4, decod5: STD_LOGIC_VECTOR(15 downto 0);
signal empty, fme, fma, price_calculated, ce_ra, rb_s2, tc_pl, empty_dest, empty_tk, done: STD_LOGIC;
signal price_intern, sum_intern, sg_in, dis_mux_o, rest_intern, rest_intern2, cr_output: STD_LOGIC_VECTOR(7 downto 0);
signal count, count2, count3, count4, count5: STD_LOGIC_VECTOR(3 downto 0);
signal pl_sr, pl_cr, mode_cr, ice_1e, ice_5e, ice_10e, ice_20e, ice_50e, ce_cr, z_1e, z_5e, z_10e, z_20e, z_50e, ce_1e, ce_5e, ce_10e, ce_20e, ce_50e,  empty2: STD_LOGIC;
signal tk_count: STD_LOGIC_VECTOR(3 downto 0);
signal pe_output: STD_LOGIC_VECTOR(2 downto 0);
signal pe_input: STD_LOGIC_VECTOR(7 downto 0);
signal dis_mux_in: STD_LOGIC_VECTOR(63 downto 0);
begin
	state_output <= (15 => '1', 14 => decod4(4), 13 => empty2, 12 => decod5(4), 11 => decod2(4), 10 => empty2 or done, 9 => fme or fma, 8 => decod3(4), 7 => cancel_btn, 6 => decod(4), 5 => price_calculated, 4 => enter_btn and empty_dest, 3 => cancel_btn, 2 => empty_tk, 1 => start_btn, others => '0');
	state_out <= state_output;
	ce_ra <= (state_in(7) or state_in(9)) and enter_btn;
	pl_sr <= not state_in(4);
	RA: register_adder port map (inputs(0) => input(0), inputs(1) => input(1), inputs(2) => input(2), clock => clock1, ce => ce_ra, reset => state_in(1), q => sum_intern);
	PC: price_calculator port map (clock => clock1, ce_sr => state_in(5), ce_counter => state_in(5), ce_dr => state_in(5), pl_sr => pl_sr, reset => state_in(1), d_sr => input, price_calculated => price_calculated, empty_dest => empty_dest, q_dr => price_intern);
	COMP: comparator generic map (8) port map (sum_intern, price_intern, fmi, fme, fma);
	C: counter_n generic map ("0100", "0000") port map (reset => state_in(1), clock => clock2, ce => state_in(6), mode => '0', pl => '1', d => "0000", q => count);
	C2: counter_n generic map ("0100", "0000") port map (reset => state_in(1), clock => clock2, ce => state_in(11), mode => '0', pl => '1', d => "0000", q => count2);
	C3: counter_n generic map ("0100", "0000") port map (reset => state_in(1), clock => clock2, ce => state_in(8), mode => '0', pl => '1', d => "0000", q => count3);
	C4: counter_n generic map ("0100", "0000") port map (reset => state_in(1), clock => clock2, ce => state_in(14), mode => '0', pl => '1', d => "0000", q => count4);
	C5: counter_n generic map ("0100", "0000") port map (reset => state_in(1), clock => clock2, ce => state_in(12), mode => '0', pl => '1', d => "0000", q => count5);
	DCD: decoder generic map (4) port map (count, decod);
	DCD2: decoder generic map (4) port map (count2, decod2);
	DCD3: decoder generic map (4) port map (count3, decod3);
	DCD4: decoder generic map (4) port map (count4, decod4);
	DCD5: decoder generic map (4) port map (count5, decod5);
	segment_out <= sg_in;
	pe_input <= "00" & (state_in(3) or state_in(4)) & state_in(6) & ((state_in(7) or state_in(9)) or state_in(8)) & state_in(14) & state_in(11) & '1';
	PE: priority_encoder generic map (3) port map (pe_input, pe_output);
	dis_mux_in(63 downto 48) <= (others => '0'); 
	dis_mux_in(47 downto 0) <= input & price_intern & sum_intern & rest_intern & rest_intern2 & "00000000";
	DISPLAY_MUX: mux_n generic map (3, 8) port map (pe_output, dis_mux_in, sg_in);
	pl_cr <= not state_in(0);
	mode_cr <= state_in(10) or (state_in(8) or state_in(13));
	ce_cr <= (state_in(7) or state_in(9)) and enter_btn;
	ice_1e <= (ce_cr and cr_output(0)) or (ce_1e and (state_in(10) or state_in(13)));
	ice_5e <= (ce_cr and cr_output(1)) or (ce_5e and (state_in(10) or state_in(13)));
	ice_10e <= (ce_cr and cr_output(2)) or (ce_10e and (state_in(10) or state_in(13)));
	ice_20e <= (ce_cr and cr_output(3)) or (ce_20e and (state_in(10) or state_in(13)));
	ice_50e <= (ce_cr and cr_output(4)) or (ce_50e and (state_in(10) or state_in(13)));
	CR: cash_register port map (pl_cr, clock1, mode_cr, '0', input(2 downto 0), ice_1e, ice_5e, ice_10e, ice_20e, ice_50e, open, open, open, open, open, cr_output, z_1e, z_5e, z_10e, z_20e, z_50e);
	rb_s2 <= state_in(14) or state_in(8);
	empty2 <= empty and (state_in(10) or state_in(13));
	RB: rest_block port map (sum_intern, price_intern, state_in(8), rb_s2, clock1, state_in(1), '1', state_in(10), z_1e, z_5e, z_10e, z_20e, z_50e, ce_1e, ce_5e, ce_10e, ce_20e, ce_50e, empty, rest_intern, rest_intern2);
	tc_pl <= not state_in(0);
	TICKET_COUNTER: counter_n generic map ("1111", "0000") port map ('0', clock1, state_in(15), '1', tc_pl, "1111", tk_count);
	OG2: or_gate_n generic map (4) port map (tk_count, empty_tk);
	process (ice_50e, ice_20e, ice_10e, ice_5e, ice_1e)
	variable v: STD_LOGIC;
	begin
		v := '0';
		v := ice_50e or v;
		v := ice_20e or v;
		v := ice_10e or v;
		v := ice_5e or v;
		v := ice_1e or v;
		done <= not v;
	end process;
	empty_out <= empty;
	empty_ticket <= empty_tk;
	q_c <= tk_count;
end Behavioral;

