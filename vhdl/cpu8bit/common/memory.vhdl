LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY memory IS 
    GENERIC (M: INTEGER := 16; N: INTEGER := 16);
    PORT (clk : IN STD_LOGIC;
          writeEnable : IN STD_LOGIC;
          address : IN STD_LOGIC_VECTOR(M-1 DOWNTO 0);
          dataIn : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          dataOut : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavior OF memory IS
    TYPE memoryBank IS ARRAY (0 TO 2**M-1) OF STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL mem : memoryBank;
BEGIN
    PROCESS(clk, writeEnable, address)
        VARIABLE index : INTEGER RANGE 0 TO 2**M-1;
    BEGIN
        index := to_integer(UNSIGNED(address));
        -- when clock edge rises
        IF (clk'EVENT AND clk='1') THEN
            IF (writeEnable = '1') THEN
                mem(index) <= dataIn;
                dataOut <= (OTHERS => '0');
            ELSE
                dataOut <= mem(index);
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;
