LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_bitSerialMult IS END ENTITY;

ARCHITECTURE test_bench OF tb_bitSerialMult IS
    COMPONENT bitSerialMult IS
        GENERIC (N : INTEGER := 16);
        PORT (clk, reset : IN STD_LOGIC;
              x : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              y : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              z : OUT STD_LOGIC_VECTOR(2*N - 1 DOWNTO 0);
              ready : BUFFER STD_LOGIC);
    END COMPONENT;
    
    SIGNAL clk, reset : STD_LOGIC := '0';

    SIGNAL x : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL y : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL z : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL ready : STD_LOGIC;
    
BEGIN
    clk <= NOT clk AFTER 10 ns;

    DUT : bitSerialMult GENERIC MAP (16) PORT MAP (clk, reset, x, y, z, ready);
    
    PROCESS
    BEGIN
        -- test case 1
        x <= X"0002";
        y <= X"0004";
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 320 ns; -- 16 * 20 ns
        WAIT FOR 660 ns; -- 33 * 20 ns

        -- test case 2
        x <= X"000B";
        y <= X"000A";
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 320 ns; -- 16 * 20 ns
        WAIT FOR 660 ns; -- 33 * 20 ns

        -- test case 3
        x <= X"0111";
        y <= X"0011";
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 320 ns; -- 16 * 20 ns
        WAIT FOR 660 ns; -- 33 * 20 ns

        -- test case 4
        x <= X"FFFF";
        y <= X"0000";
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 320 ns; -- 16 * 20 ns
        WAIT FOR 660 ns; -- 33 * 20 ns

        -- test case 5
        x <= X"1111";
        y <= X"0001";
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 320 ns; -- 16 * 20 ns
        WAIT FOR 660 ns; -- 33 * 20 ns
    
        -- test case 6
        x <= X"F000";
        y <= X"000F";
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        WAIT FOR 320 ns; -- 16 * 20 ns
        WAIT FOR 660 ns; -- 33 * 20 ns
    END PROCESS;

END ARCHITECTURE;

CONFIGURATION tb_bitSerialMult_conf OF tb_bitSerialMult IS
    FOR test_bench
    END FOR;
END tb_bitSerialMult_conf;
