LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- Generic width program counter
ENTITY pc IS
    GENERIC (N: INTEGER := 16);
    PORT (clk, inc, load, reset : IN STD_LOGIC;
          d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavior OF pc IS
BEGIN
    PROCESS (clk, inc, load, reset)
        VARIABLE count : INTEGER RANGE 0 TO 2**N - 1;
    BEGIN
        IF (reset = '1') THEN
            count := 0;
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (load = '1') THEN
                count := to_integer(UNSIGNED(d));
            ELSIF (inc = '1') THEN
                count := count + 1;
            END IF;
        END IF;
        q <= STD_LOGIC_VECTOR(to_unsigned(count, q'LENGTH));
    END PROCESS;
END ARCHITECTURE;
