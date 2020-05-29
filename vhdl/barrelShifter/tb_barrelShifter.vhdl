LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_barrelShifter IS END ENTITY;

ARCHITECTURE test_bench OF tb_barrelShifter IS
    COMPONENT barrelShifter IS
        PORT (a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
              b : IN INTEGER RANGE 0 TO 15;
              dir : IN STD_LOGIC;
              c : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

    SIGNAL a : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL b : INTEGER RANGE 0 TO 15 := 0;
    SIGNAL dir : STD_LOGIC := '0';
    SIGNAL c : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
    DUT : barrelShifter PORT MAP (a, b, dir, c);
    
    PROCESS
    BEGIN
        a <= X"F00F";
        b <= 2;
        dir <= '0';
        WAIT FOR 10 ns;

        a <= X"ABCD";
        b <= 1;
        dir <= '1';
        WAIT FOR 10 ns;

        a <= X"111F";
        b <= 3;
        dir <= '0';
        WAIT FOR 10 ns;
        
        a <= X"FFFF";
        b <= 0;
        dir <= '1';
        WAIT FOR 10 ns;

        a <= X"0000";
        b <= 5;
        dir <= '0';
        WAIT FOR 10 ns;
        
        a <= X"EEEE";
        b <= 8;
        dir <= '1';
        WAIT FOR 10 ns;

        a <= X"EEEE";
        b <= 15;
        dir <= '1';
        WAIT FOR 10 ns;

    END PROCESS;
END ARCHITECTURE;
