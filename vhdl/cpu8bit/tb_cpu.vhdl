LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE std.textio.all;

ENTITY tb_cpu IS
END ENTITY;

ARCHITECTURE testbench OF tb_cpu IS
    -- Design under test
    COMPONENT cpu IS
        GENERIC (ADDRESS_SIZE: INTEGER := 10; DATA_SIZE: INTEGER := 16);
        PORT (clk, enable, reset : IN STD_LOGIC;
              weIM : IN STD_LOGIC;
              codeAddress : IN STD_LOGIC_VECTOR(ADDRESS_SIZE-1 DOWNTO 0);
              codeIn : IN STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);
              dataOut : OUT STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0));
    END COMPONENT;

    SIGNAL clk, enable, reset : STD_LOGIC := '0';
    SIGNAL weIM : STD_LOGIC;
    SIGNAL codeAddress : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL codeIn, dataOut : STD_LOGIC_VECTOR(15 DOWNTO 0);
    
    FILE programFile : TEXT OPEN READ_MODE IS "program.tst";
    
    -- converts a character into a std_logic
    FUNCTION to_std_logic(c: CHARACTER) RETURN STD_LOGIC IS
        VARIABLE sl: STD_LOGIC;
        BEGIN
          CASE c IS
            WHEN 'U' => 
               sl := 'U'; 
            WHEN 'X' =>
               sl := 'X';
            WHEN '0' => 
               sl := '0';
            WHEN '1' => 
               sl := '1';
            WHEN 'Z' => 
               sl := 'Z';
            WHEN 'W' => 
               sl := 'W';
            WHEN 'L' => 
               sl := 'L';
            WHEN 'H' => 
               sl := 'H';
            WHEN '-' => 
               sl := '-';
            WHEN others =>
               sl := 'X'; 
        END CASE;
       RETURN sl;
    END to_std_logic;

    -- converts a string into std_logic_vector
    FUNCTION to_std_logic_vector(s: STRING) RETURN STD_LOGIC_VECTOR IS
        VARIABLE slv: STD_LOGIC_VECTOR(s'HIGH-s'LOW DOWNTO 0);
        VARIABLE k: INTEGER;
    BEGIN
        k := s'HIGH-s'LOW;
        FOR i IN s'RANGE LOOP
            slv(k) := to_std_logic(s(i));
            k      := k - 1;
        END LOOP;
        RETURN slv;
    END to_std_logic_vector;        

BEGIN
    DUT : cpu GENERIC MAP (10, 16) PORT MAP (clk, enable, reset, weIM,
                                             codeAddress, codeIn, dataOut);
                                         
    clk <= NOT clk AFTER 10 ns;
    
    PROCESS
        VARIABLE programLine : LINE;
        VARIABLE spaceCharacter : STRING(1 TO 1);
        VARIABLE programInstruction : STRING(1 TO 16);
        VARIABLE programAddress : INTEGER;
        VARIABLE goodValue : BOOLEAN;
    BEGIN
    
        -- disable controller and reset registers
        enable <= '0';
        reset <= '1';
        WAIT FOR 20 ns;
        reset <= '0';
        weIM <= '1';
        
        -- load program data from file
        programAddress := 0;
        WHILE NOT ENDFILE(programFile) LOOP
            READLINE(programFile, programLine);
            READ(programLine, programInstruction, goodValue);
            ASSERT goodValue REPORT "Invalid value in file" SEVERITY FAILURE;
            -- load instruction into CPU
            codeAddress <= std_logic_vector(to_unsigned(programAddress, codeAddress'LENGTH));
            codeIn <= to_std_logic_vector(programInstruction);
            WAIT FOR 20 ns;
            -- increment program address
            programAddress := programAddress + 1;
        END LOOP;
        
        -- enable controller and prepare for execution
        enable <= '0';
        weIM <= '0';
        WAIT FOR 20 ns;
        enable <= '1';
        
        -- execute program
--      FOR i IN 1 TO programAddress LOOP
        FOR i IN 1 TO 1000 LOOP
            WAIT FOR 60 ns;
        END LOOP;
        
    END PROCESS;

END ARCHITECTURE;
