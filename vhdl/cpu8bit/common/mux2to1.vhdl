LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- 2 to 1 generic width multiplexer
ENTITY mux2to1 IS
    GENERIC (N: INTEGER := 16);
    PORT (x, y : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          sel : IN STD_LOGIC;
          z : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE dataflow OF mux2to1 IS
BEGIN
    z <= x WHEN sel='0' ELSE y;
END ARCHITECTURE;
