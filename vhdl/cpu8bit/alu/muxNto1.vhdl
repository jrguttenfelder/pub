LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- N to 1 generic width multiplexer
ENTITY muxNto1 IS
    GENERIC (N: INTEGER := 16);
    PORT (x : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          sel : IN INTEGER RANGE 0 TO N-1;
          y : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF muxNto1 IS
BEGIN
    y <= x(sel);
END ARCHITECTURE;
