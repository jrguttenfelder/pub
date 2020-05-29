LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY bitSerialMult IS
    GENERIC (N : INTEGER := 16);
    PORT (clk, reset : IN STD_LOGIC;
          x : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          y : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          z : OUT STD_LOGIC_VECTOR(2*N - 1 DOWNTO 0);
          ready : BUFFER STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior OF bitSerialMult IS

    COMPONENT bitSerialAdder IS
        PORT (clk, reset : IN STD_LOGIC;
              a, b : IN STD_LOGIC;
              sum : OUT STD_LOGIC);
    END COMPONENT;
    
    COMPONENT shiftRegister IS
        GENERIC (N: INTEGER := 8);
        PORT (clk, reset : IN STD_LOGIC;
              x : IN STD_LOGIC;
              y : OUT STD_LOGIC);
    END COMPONENT;
    
    COMPONENT serializer IS
        GENERIC (N : INTEGER := 8);
        PORT (clk, reset : IN STD_LOGIC;
              x : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              y : OUT STD_LOGIC);
    END COMPONENT;
    
    SIGNAL multiplier : STD_LOGIC;
    SIGNAL product : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL product_delay : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL sum : STD_LOGIC_VECTOR(N DOWNTO 0);

BEGIN

    serialize_x : serializer GENERIC MAP (N) PORT MAP (clk, reset, x, multiplier);

    and_gen : FOR i IN 0 TO N-1 GENERATE
        product(i) <= multiplier AND y(N-i-1);
    END GENERATE;

    product_delay(0) <= product(0);
    delay_gen : FOR i IN 1 TO N-1 GENERATE
        delay_i : shiftRegister GENERIC MAP (i) PORT MAP (clk, reset, product(i), product_delay(i));
    END GENERATE;

    sum(0) <= '0';
    adder_gen : FOR i IN 0 TO N-1 GENERATE
        adder_i : bitSerialAdder PORT MAP (clk, reset, 
                                           sum(i), product_delay(i), sum(i+1)); 
    END GENERATE;
    
    deserialize_z : PROCESS (clk, reset)
        VARIABLE index : INTEGER RANGE 0 TO 2*N + N + 1;
    BEGIN
        IF (reset = '1') THEN
            z <= (OTHERS => '0');
            index := 0;
            ready <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (ready = '0' AND index > N) THEN
                z(index - N - 1) <= sum(N);
            END IF;
            
            index := index + 1;
            IF (index = 2*N + N + 1) THEN
                ready <= '1';
                index := 0;
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE;
