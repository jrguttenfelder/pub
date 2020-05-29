LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Generic width loadable register
ENTITY registerN IS
    GENERIC (N: INTEGER := 16);
    PORT (clk, load, reset : IN STD_LOGIC;
          d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavior OF registerN IS
BEGIN
    PROCESS (clk, load, reset)
    BEGIN
        IF (reset = '1') THEN
            q <= (OTHERS => '0');
        ELSIF (clk'EVENT AND clk = '1' AND load='1') THEN
            q <= d;
        END IF;
    END PROCESS;
END ARCHITECTURE;
