LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_bitSerialAdder IS END ENTITY;

ARCHITECTURE test_bench OF tb_bitSerialAdder IS
    COMPONENT bitSerialAdder IS
        PORT (clk, reset : IN STD_LOGIC;
              a, b : IN STD_LOGIC;
              sum : OUT STD_LOGIC);
    END COMPONENT;
    
    SIGNAL clk, reset : STD_LOGIC := '0';
    SIGNAL x, y : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL a, b : STD_LOGIC;
    SIGNAL sum : STD_LOGIC;
BEGIN
    DUT : bitSerialAdder PORT MAP (clk, reset, a, b, sum);

    clk <= NOT clk AFTER 10 ns;
    
    PROCESS
    BEGIN
        -- test case 1
        reset <= '1';
        x <= "00";
        y <= "00";
        WAIT FOR 20 ns;
        
        reset <= '0';
        FOR i IN 0 TO 1 LOOP
            a <= x(i);
            b <= y(i);
            WAIT FOR 20 ns;
        END LOOP;

        a <= '0';
        b <= '0';
        WAIT FOR 20 ns;
        WAIT FOR 20 ns;
        
        -- test case 2
        reset <= '1';
        x <= "01";
        y <= "00";
        WAIT FOR 20 ns;
        
        reset <= '0';
        FOR i IN 0 TO 1 LOOP
            a <= x(i);
            b <= y(i);
            WAIT FOR 20 ns;
        END LOOP;

        a <= '0';
        b <= '0';
        WAIT FOR 20 ns;
        WAIT FOR 20 ns;

        -- test case 3
        reset <= '1';
        x <= "10";
        y <= "00";
        WAIT FOR 20 ns;
        
        reset <= '0';
        FOR i IN 0 TO 1 LOOP
            a <= x(i);
            b <= y(i);
            WAIT FOR 20 ns;
        END LOOP;

        a <= '0';
        b <= '0';
        WAIT FOR 20 ns;
        WAIT FOR 20 ns;
        
        -- test case 4
        reset <= '1';
        x <= "11";
        y <= "01";
        WAIT FOR 20 ns;
        
        reset <= '0';
        FOR i IN 0 TO 1 LOOP
            a <= x(i);
            b <= y(i);
            WAIT FOR 20 ns;
        END LOOP;

        a <= '0';
        b <= '0';
        WAIT FOR 20 ns;
        WAIT FOR 20 ns;
        
        -- test case 5
        reset <= '1';
        x <= "11";
        y <= "11";
        WAIT FOR 20 ns;
        
        reset <= '0';
        FOR i IN 0 TO 1 LOOP
            a <= x(i);
            b <= y(i);
            WAIT FOR 20 ns;
        END LOOP;

        a <= '0';
        b <= '0';
        WAIT FOR 20 ns;
        WAIT FOR 20 ns;
        
    END PROCESS;

END ARCHITECTURE;

CONFIGURATION tb_bitSerialAdder_conf OF tb_bitSerialAdder IS
    FOR test_bench
    END FOR;
END tb_bitSerialAdder_conf;
