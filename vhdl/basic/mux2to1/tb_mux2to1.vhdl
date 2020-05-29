library ieee;
use ieee.std_logic_1164.ALL;

-- test bench Multiplexer 2 to 1 entity declaration
entity tb_mux2to1 is
end tb_mux2to1;

-- test bench Multiplexer 2 to 1 structure definition
architecture structure of tb_mux2to1 is

    -- define the multiplexer 2 to 1 gate component to be used in test bench
    component Multiplexer2to1 is
        port ( A, B: IN std_logic;
               Sel: IN std_logic; -- select line for the multiplexer.
               MuxOut: OUT std_logic); -- output the selected input (A for Sel=0)
    end component;

    signal A, B, Sel : std_logic; -- setup internal "input" signals
    signal Out_MuxOut : std_logic; -- setup internal "output" signals

-- begin test bench behaviour
begin
    -- map input and output signals to Multiplexer2to1 ports
    DUT : Multiplexer2to1 port map (A, B, Sel, Out_MuxOut); -- instantiate "mux2to1"
    process
    begin
        Sel <= '0'; B <= '0'; A <= '0';
        wait for 10 ns;
        Sel <= '0'; B <= '0'; A <= '1';
        wait for 10 ns;
        Sel <= '0'; B <= '1'; A <= '0';
        wait for 10 ns;
        Sel <= '0'; B <= '1'; A <= '1';
        wait for 10 ns;
        Sel <= '1'; B <= '0'; A <= '0';
        wait for 10 ns;
        Sel <= '1'; B <= '0'; A <= '1';
        wait for 10 ns;
        Sel <= '1'; B <= '1'; A <= '0';
        wait for 10 ns;
        Sel <= '1'; B <= '1'; A <= '1';
        wait for 10 ns;
    end process;
end structure;
