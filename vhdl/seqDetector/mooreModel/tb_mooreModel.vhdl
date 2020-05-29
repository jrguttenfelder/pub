LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_mooreModel IS
END tb_mooreModel;

ARCHITECTURE behavior OF tb_mooreModel IS
    COMPONENT seqdetector
        port (clk, input, reset : in std_logic;
              output : out std_logic -- '1' indicates that the pattern is detected
              );
    END COMPONENT;

    --Inputs
    signal CLK : std_logic := '0';
    signal RESET : std_logic := '0';
    signal X : std_logic := '0';

    --Outputs
    Signal Z : std_logic;

BEGIN
    uut: seqdetector PORT MAP (
        clk => CLK,
        reset => RESET,
        input => X,
        output => Z
    );

    CLK <= not CLK after 10 ns;
    
    -- Stimulus process
    stim_proc: process
    begin
        RESET <= '1';
        wait for 30 ns;
        RESET <= '0';
        X <= '1';
        wait for 20 ns;
        X <= '1';
        wait for 20 ns;
        X <= '0';
        wait for 20 ns;
        X <= '1';
        wait for 20 ns;
        X <= '0';
        wait for 20 ns;
        X <= '1';
        wait for 20 ns;
        X <= '0';
        wait for 20 ns;
        X <= '1';
        wait for 20 ns;
    end process;
END;
