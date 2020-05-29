library ieee;
use ieee.std_logic_1164.ALL;

-- test bench AND entity declaration
entity tb_and8 is
end tb_and8;

-- test bench AND structure definition
architecture structure of tb_and8 is

    -- define the 8-port AND gate component to be used in test bench
    component and8 is
        port ( D : in std_logic_VECTOR (7 downto 0);
               out1 : out std_logic);
    end component;

    -- declare signals for input and output of 8-port AND gate
    signal D : std_logic_VECTOR (7 downto 0); -- setup internal "input" signals
    signal out_and8 : std_logic; -- setup internal "output" signals

-- begin test bench behaviour
begin
    -- map input and output signals to and8 ports
    DUT : and8 port map (D, out_and8); --instantiate "and8"
    process
    begin
        D <= "00000000";
        wait for 10 ns;
        D <= "01010101";
        wait for 10 ns;
        D <= "11111111";
        wait for 10 ns;
        D <= "11110000";
        wait for 10 ns;
    end process;
end structure;
