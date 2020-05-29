library ieee;
use ieee.std_logic_1164.all;

entity tb_fullAdder16 is
end tb_fullAdder16;

-- purpose: Simulating the Full Adder design
architecture structure of tb_fullAdder16 is

    component fullAdder16
        port ( A,B: in std_logic_vector(15 downto 0);
               Cin: in std_logic;
               Sum: out std_logic_vector(15 downto 0);
               Cout: out std_logic);
    end component;

    signal A,B,Sum : std_logic_vector(15 downto 0);
    signal Cin,Cout : std_logic;

begin -- structure
    DUT: fullAdder16 port map (A,B,Cin,Sum,Cout);
    process
    begin
        wait for 0 ns;
        
        A <= x"0001"; B <= x"0002"; Cin <= '0'; -- Specify input values.
        wait for 10 ns;

        A <= x"0003"; -- Only change the value of A.
        wait for 10 ns;

        B <= x"0004"; Cin <= '1'; -- Change values of B and Cin.
        wait for 10 ns;

        A <= x"0005"; B <= x"0006"; -- Change values of A and B.
        wait for 10 ns;

        Cin <= '0'; -- Change the value of Cin.
        wait for 5 ns;
    end process;
end structure;
