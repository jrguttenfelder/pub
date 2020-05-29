library ieee;
use ieee.std_logic_1164.all;

-- test bench AND entity declaration
entity tb_and2 is
end tb_and2;

-- test bench AND structure definition
architecture structure of tb_and2 is

    -- define the 2-port AND gate component to be used in test bench
    component and2 is
        port (in1, in2 : in std_logic;
              out1     : out std_logic);
    end component;

    -- declare signals for input and output of 2-port AND gate
    signal in1, in2 : std_logic;
    signal out_and2 : std_logic;

    -- begin test bench behaviour
    begin
    -- map input and output signals to and2 ports
        DUT : and2 port map (in1, in2, out_and2); -- instantiate "and2"
        process
        begin
            in2 <= '0'; in1 <= '0';
            wait for 10 ns;
            in2 <= '0'; in1 <= '1';
            wait for 10 ns;
            in2 <= '1'; in1 <= '0';
            wait for 10 ns;
            in2 <= '1'; in1 <= '1';
            wait for 10 ns;
        end process;
end structure;
