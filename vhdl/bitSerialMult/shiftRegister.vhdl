LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entity definition for Shift Register (delay element)
ENTITY shiftRegister IS
    GENERIC (N: INTEGER := 8);
    PORT (clk, reset : IN STD_LOGIC;
          x : IN STD_LOGIC;
          y : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF shiftRegister IS
BEGIN
    PROCESS (clk, reset)
        VARIABLE q: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    BEGIN
        -- if reset is set, then clear buffer
        IF (reset = '1') THEN
            q := (OTHERS => '0');
        -- append input to buffer values 0 to N-2
        ELSIF (clk'EVENT AND clk='1') THEN
            IF (N > 1) THEN
                q := q(N-2 DOWNTO 0) & x;
            ELSE
                q(0) := x;
            END IF;
        END IF;
        -- set output to last value in buffer
        y <= q(N-1);
    END PROCESS;
END ARCHITECTURE;

