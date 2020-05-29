LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entity definition for serializer
ENTITY serializer IS
    GENERIC (N : INTEGER := 8);
    PORT (clk, reset : IN STD_LOGIC;
          x : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          y : OUT STD_LOGIC);
END ENTITY;

-- behavior definition of serializer
ARCHITECTURE behavior OF serializer IS
BEGIN
    PROCESS (clk, reset)
        VARIABLE index : INTEGER RANGE 0 TO N;
    BEGIN
        -- if reset is set, then set index to 0 
        -- and set y to first x bit
        IF (reset = '1') THEN
            index := 0;
            y <= x(0);
        -- if clk is high, then set y to next x bit
        ELSIF (clk'EVENT and clk='1') THEN
            IF (index+1 < N) THEN
                y <= x(index+1);
            ELSE
                y <= '0';
            END IF;
            
            IF (index < N) THEN
                index := index + 1;
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;

