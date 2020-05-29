library ieee;
use ieee.std_logic_1164.ALL;

entity tb_comparator8 is
end tb_comparator8;

architecture tb_behavior of tb_comparator8 is

	-- Component Declaration for the Unit Under Test (UUT)
	component comparator8
		port (a : in std_logic_vector(7 downto 0);
		      b : in std_logic_vector(7 downto 0);
			  AeqB : out std_logic;
			  AltB : out std_logic;
			  AgtB : out std_logic);
	end component;

	--Inputs
	signal a : std_logic_vector(7 downto 0);
	signal b : std_logic_vector(7 downto 0);

	--Outputs
	signal AeqB : std_logic;
	signal AltB : std_logic;
	signal AgtB : std_logic;
	
begin
	-- Instantiate the Unit Under Test (UUT)
	Uut: comparator8 port map (a, b, AeqB, AltB, AgtB);
	tb: process
	begin
		-- equal
		a<="00000000"; b<="00000000"; wait for 10 ns;
		-- less than
		a<="00010000"; b<="00100000"; wait for 10 ns;
		-- greater than
		a<="00001100"; b<="00001000"; wait for 10 ns;
		-- greater than
		a<="01010000"; b<="01000000"; wait for 10 ns;
		-- less than
		a<="01110000"; b<="10000000"; wait for 10 ns;
	end process;
end tb_behavior;
