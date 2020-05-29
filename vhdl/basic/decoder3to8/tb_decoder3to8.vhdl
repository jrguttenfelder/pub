library ieee;
use ieee.std_logic_1164.ALL;

-- test bench Decoder 3-8 entity declaration
entity tb_decoder3to8 is
end tb_decoder3to8;

-- test bench Decoder 3-8 structure definition
architecture structure of tb_decoder3to8 is

    -- define the Decoder 3-8 gate component to be used in test bench
    component decoder3to8 is
        port ( A, B, C : in std_logic;
               Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7 : out std_logic);
    end component;

    signal A, B, C : std_logic; -- setup internal "input" signals
    signal Out_Y0, Out_Y1, Out_Y2, Out_Y3 : std_logic; -- setup internal "output" signals
    signal Out_Y4, Out_Y5, Out_Y6, Out_Y7 : std_logic; -- setup internal "output" signals

-- begin test bench behaviour
begin
    -- map input and output signals to decoder3to8 ports
    DUT : decoder3to8 port map (A, B, C, 
                                Out_Y0, Out_Y1, Out_Y2, Out_Y3,
                                Out_Y4, Out_Y5, Out_Y6, Out_Y7); --instantiate "decoder2to4"); --instantiate "decoder3to8"
    process
    begin
        C <= '0'; B <= '0'; A <= '0';
        wait for 10 ns;
        C <= '0'; B <= '0'; A <= '1';
        wait for 10 ns;
        C <= '0'; B <= '1'; A <= '0';
        wait for 10 ns;
        C <= '0'; B <= '1'; A <= '1';
        wait for 10 ns;
        C <= '1'; B <= '0'; A <= '0';
        wait for 10 ns;
        C <= '1'; B <= '0'; A <= '1';
        wait for 10 ns;
        C <= '1'; B <= '1'; A <= '0';
        wait for 10 ns;
        C <= '1'; B <= '1'; A <= '1';
        wait for 10 ns;
    end process;
end structure;
