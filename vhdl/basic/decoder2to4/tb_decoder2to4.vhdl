library ieee;
use ieee.std_logic_1164.ALL;

-- test bench Decoder 2-4 entity declaration
entity tb_decoder2to4 is
end tb_decoder2to4;

-- test bench Decoder 2-4 structure definition
architecture structure of tb_decoder2to4 is

    -- define the Decoder 2-4 gate component to be used in test bench
    component decoder2to4 is
        port ( A, B : in std_logic;
               Y0,Y1,Y2,Y3 : out std_logic);
    end component;

    signal A,B : std_logic; -- setup internal "input" signals
    signal Out_Y0, Out_Y1, Out_Y2, Out_Y3 : std_logic; -- setup internal "output" signals

-- begin test bench behaviour
begin
    -- map input and output signals to decoder2to4 ports
    DUT : decoder2to4 port map (A, B, Out_Y0, Out_Y1, Out_Y2, Out_Y3); --instantiate "decoder2to4"
    process
    begin
        B <= '0'; A <= '0';
        wait for 10 ns;
        B <= '0'; A <= '1';
        wait for 10 ns;
        B <= '1'; A <= '0';
        wait for 10 ns;
        B <= '1'; A <= '1';
        wait for 10 ns;
    end process;
end structure;
