library ieee;
use ieee.std_logic_1164.ALL;

-- test bench Multiplexer 4 to 1 entity declaration
entity tb_mux4to1 is
end tb_mux4to1;

-- test bench Multiplexer 4 to 1 structure definition
architecture structure of tb_mux4to1 is

    -- define the multiplexer 4 to 1 gate component to be used in test bench
    component mux4to1 is
        port ( D : IN std_logic_vector (3 downto 0); -- 4 bit data
               Sel : IN std_logic_vector (1 downto 0); -- 2 bit select line
               Y : OUT std_logic); -- output data value
    end component;

    signal D : std_logic_vector (3 downto 0);
    signal Sel : std_logic_vector (1 downto 0);
    signal Out_MuxOut : std_logic; 

-- begin test bench behaviour
begin
    -- map input and output signals to mux4to1 ports
    DUT : mux4to1 port map (D, Sel, Out_MuxOut); -- instantiate "mux4to1"
    process
    begin
        Sel <= "00"; D <= "0000";
        wait for 10 ns;
        Sel <= "00"; D <= "0001";
        wait for 10 ns;
        Sel <= "01"; D <= "0000";
        wait for 10 ns;
        Sel <= "01"; D <= "0010";
        wait for 10 ns;
        Sel <= "10"; D <= "0000";
        wait for 10 ns;
        Sel <= "10"; D <= "0100";
        wait for 10 ns;
        Sel <= "11"; D <= "0000";
        wait for 10 ns;
        Sel <= "11"; D <= "1000";
        wait for 10 ns;
    end process;
end structure;
