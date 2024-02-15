----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:57:15 04/26/2022 
-- Design Name: 
-- Module Name:    debounce - Behavioral 
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

entity debouncer is
	port (input, clock, reset: in STD_LOGIC;
			output: out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is
component d_flip_flop is
	port (reset, clock, d, ce: in STD_LOGIC;
			q, qn: out STD_LOGIC);
end component;
signal temp1, temp2, temp3, ioutput: STD_LOGIC;
signal lastButtonState: std_logic;
begin
	U1: d_flip_flop port map ('0', clock, input, '1', temp1, open);
	U2: d_flip_flop port map ('0', clock, temp1, '1', temp2, open);
	U3: d_flip_flop port map ('0', clock, temp2, '1', temp3, open);
	ioutput <= (temp1 and temp2) and temp3;

	process(clock, reset)
	begin
	  if reset = '1' then
		  lastButtonState <= '0';
	  elsif(clock = '1' and clock'event) then
		 if(ioutput = '1' and lastButtonState = '0') then
			output <= '1';
		 else
			output <= '0';
		 end if;
		 lastButtonState <= ioutput;
	  end if;
	end process;
	
end Behavioral;

