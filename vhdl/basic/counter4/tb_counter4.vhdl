library ieee;
use ieee.std_logic_1164.all;

-- test bench entity definition
entity tb_counter4 is
end tb_counter4;

-- test bench structure
architecture structure of tb_counter4 is
	
	-- define 4-bit counter component
	component counter4
		port (clk,reset : in std_logic;
			  count : out std_logic_vector(3 downto 0)
		);
	end component;

	-- define signals to use for D Flip Flop
	signal reset : std_logic:='0';
	signal clk : std_logic := '1';
	signal count : std_logic_vector(3 downto 0) := "0000";

begin
	DUT : counter4 port map (clk, reset, count);
	
	-- cycle clock signal every 10 ns
	clk <= not clk after 10 ns;
	process
	begin
		-- test reset operation
		reset <= '1';
		wait for 20 ns;
		
		-- clear reset and wait for increment 1
		reset <= '0';
		wait for 20 ns;
		
		-- wait for increment 2
		wait for 20 ns;

		-- wait for increment 3
		wait for 20 ns;

		-- wait for increment 4
		wait for 20 ns;

		-- wait for increment 6
		wait for 20 ns;
		
	end process;
end structure;
