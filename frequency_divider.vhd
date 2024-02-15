----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:16:19 03/21/2022 
-- Design Name: 
-- Module Name:    frequency_divider - Behavioral 
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

entity frequency_divider is
	generic (n: integer);
	port (clk, reset: in std_logic;
			clock_out: out std_logic);
end frequency_divider;

architecture Behavioral of frequency_divider is
signal count: integer;
signal tmp : std_logic;
begin
	process(clk, reset, tmp)
	begin
		if(reset='1') then
			count<=1;
			tmp<='0';
		elsif(clk'event and clk='1') then
			count<=count+1;
			if (count = n) then
				tmp<= NOT tmp;
				count<= 1;
			end if;
		end if;
		clock_out <= tmp;
	end process;
end Behavioral;