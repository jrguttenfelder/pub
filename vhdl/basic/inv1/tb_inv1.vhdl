library ieee;
use ieee.std_logic_1164.ALL;

-- test bench inverter entity declaration
entity tb_inv1 is
end tb_inv1;

-- test bench inverter structure definition
architecture structure of tb_inv1 is
    
    -- define the 1-port inverter gate component to be used in test bench
    component inv1 is
        port ( in1 : in std_logic;
               out1 : out std_logic);
    end component;

    -- declare signals for input and output of the inverter
    signal in1 : std_logic; -- setup internal "input" signal
    signal Out_inv1 : std_logic; -- setup internal "output" signal
    
begin
    -- map input and output signals to inv1 ports
    U1 : inv1 port map (in1, Out_inv1); --instantiate "inv1"
    process
    begin
        in1 <= '0';
        wait for 10 ns;
        in1 <= '1';
        wait for 10 ns;
        in1 <= '0';
        wait for 10 ns;
        in1 <= '1';
        wait for 10 ns;
    end process;
end structure;
