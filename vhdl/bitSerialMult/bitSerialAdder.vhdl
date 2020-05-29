LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entity definition for Full Adder
ENTITY bitSerialAdder IS
    PORT (clk, reset : IN STD_LOGIC;
          a, b : IN STD_LOGIC;
          sum : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE structure OF bitSerialAdder IS

    COMPONENT shiftRegister IS
        GENERIC (N: INTEGER := 8);
        PORT (clk, reset : IN STD_LOGIC;
              x : IN STD_LOGIC;
              y : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT fullAdder IS
        PORT (a, b, cin: IN STD_LOGIC;
              sum, cout: OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL carryOut, carryIn : STD_LOGIC;
    SIGNAL sumTemp : STD_LOGIC;
BEGIN

    carry_delay : shiftRegister GENERIC MAP (1) PORT MAP (clk, reset, carryOut, carryIn);
    adder : fullAdder PORT MAP (a, b, carryIn, sumTemp, carryOut);
    sum_delay : shiftRegister GENERIC MAP (2) PORT MAP (clk, reset, sumTemp, sum);
    
END ARCHITECTURE;

