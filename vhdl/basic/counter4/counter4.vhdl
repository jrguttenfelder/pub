library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- entity definition for 4-bit counter
-- inputs are: CLK (clock signal) and RESET (reset signal)
-- output is: COUNT
entity counter4 is
	port (clk,reset : in std_logic;
		  count : out std_logic_vector(3 downto 0)
	);
end counter4;

-- behavior definition of 4-bit counter
architecture behavior of counter4 is
begin
	-- execute process when clk changes
	process(clk)
		variable temp : integer range 0 to 31;
	begin
		-- if clk has changed and the value is 1
		if( clk'event and clk = '1') then
			-- check if reset bit is set, if so set output to 0
			if (reset = '1') then
				temp := 0;
			-- otherwise, increment value of counter
			else
				temp := temp + 1;
			end if;
			count <= std_logic_vector(to_unsigned(temp, count'LENGTH));
		end if;
	end process;
end behavior;

