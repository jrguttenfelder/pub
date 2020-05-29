library ieee;
use ieee.std_logic_1164.ALL;

-- test bench XOR entity declaration
entity tb_xor2 is
end tb_xor2;

-- test bench OR structure definition
architecture structure of tb_xor2 is

    -- define the 2-port XOR gate component to be used in test bench
    component xor2 is
        port ( In1,In2 : in std_logic;
               Out1 : out std_logic);
    end component;

    signal In1,In2 : std_logic; -- setup internal "input" signals
    signal Out_xor2 : std_logic; -- setup internal "output" signals

-- begin test bench behaviour
begin
    -- map input and output signals to xor2 ports
    DUT : xor2 port map (In1, In2, Out_xor2); --instantiate "xor2"
    process
    begin
        In2 <= '0'; In1 <= '0';
        wait for 10 ns;
        In2 <= '0'; In1 <= '1';
        wait for 10 ns;
        In2 <= '1'; In1 <= '0';
        wait for 10 ns;
        In2 <= '1'; In1 <= '1';
        wait for 10 ns;
    end process;
end structure;
