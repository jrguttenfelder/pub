LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_alu IS
    GENERIC (period : TIME := 100 ns;
             tp : TIME := 15 ns);
END ENTITY;

ARCHITECTURE testbench OF tb_alu IS
    -- Design under test
    COMPONENT alu IS
        GENERIC (N : INTEGER := 16);
        PORT (a, b: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              opcode: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
              c: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              eq, gt, za, zb, ovr : OUT STD_LOGIC);
    END COMPONENT;
    
    SIGNAL a, b, c : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL opcode : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL eq, gt, za, zb, ovr : STD_LOGIC;
    
    TYPE testcase IS RECORD
        a : STD_LOGIC_VECTOR(15 DOWNTO 0);
        b : STD_LOGIC_VECTOR(15 DOWNTO 0);
        opcode : STD_LOGIC_VECTOR(4 DOWNTO 0);
        c : STD_LOGIC_VECTOR(15 DOWNTO 0);
        eq, gt, za, zb, ovr : STD_LOGIC;
    END RECORD;
    
    TYPE table IS ARRAY (1 TO 18) OF testcase;
    CONSTANT testcases : table := (
        -- Arithmetic Unit Test Cases
        -- (A + B)
        (X"0123", X"0001", "00000", X"0124", '0', '1', '0', '0', '0'),
        -- (A + B) (overflow)
        (X"7FFF", X"0001", "00000", X"8000", '0', '1', '0', '0', '1'),
        -- (A * B) 
        (X"00F0", X"000F", "00001", X"0E10", '0', '1', '0', '0', '0'),
        -- (A * B) (overflow) 
        (X"00F0", X"0FFF", "00001", X"FF10", '0', '0', '0', '0', '1'),
        -- (A - B)
        (X"0123", X"0001", "00010", X"0122", '0', '1', '0', '0', '0'),
        -- (A - B) (overflow)
        (X"7FFF", X"FFFF", "00010", X"8000", '0', '1', '0', '0', '1'),
        -- (A / B)
        (X"0123", X"0002", "00011", X"0091", '0', '1', '0', '0', '0'),
        -- (A / B) (overflow)
        (X"0123", X"0000", "00011", X"0000", '0', '1', '0', '1', '1'),
        
        -- Logic Unit Test Cases
        -- (A AND B)
        (X"FFFF", X"FFFF", "01000", X"FFFF", '1', '0', '0', '0', '0'),
        -- (A OR B)
        (X"1010", X"0101", "01001", X"1111", '0', '1', '0', '0', '0'),
        -- (A NAND B)
        (X"FFFF", X"FFFF", "01010", X"0000", '1', '0', '0', '0', '0'),
        -- (A NOR B)
        (X"1010", X"0101", "01011", X"EEEE", '0', '1', '0', '0', '0'),
        -- (NOT A)
        (X"1010", X"0000", "01100", X"EFEF", '0', '1', '0', '1', '0'),
        -- (NOT B)
        (X"0000", X"1010", "01101", X"EFEF", '0', '0', '1', '0', '0'),
        -- (A XOR B)
        (X"1010", X"0101", "01110", X"1111", '0', '1', '0', '0', '0'),
        -- (A XNOR B)
        (X"1010", X"1010", "01110", X"0000", '1', '0', '0', '0', '0'),
        
        -- Shifter Unit Test Cases
        -- (A right shift 3 times)
        (X"1010", X"0003", "10000", X"0202", '0', '1', '0', '0', '0'),
        -- (A left shift 3 times)
        (X"1010", X"0003", "10001", X"8080", '0', '1', '0', '0', '0')
    );

BEGIN
    DUT : alu GENERIC MAP (16) PORT MAP (a, b, opcode, c, eq, gt, za, zb, ovr);
    
    PROCESS
    BEGIN
        FOR i IN table'RANGE LOOP
            a <= testcases(i).a;
            b <= testcases(i).b;
            opcode <= testcases(i).opcode;
            WAIT FOR tp;
            ASSERT c=testcases(i).c 
                    AND eq=testcases(i).eq 
                    AND gt=testcases(i).gt
                    AND za=testcases(i).za
                    AND zb=testcases(i).zb
                    AND ovr=testcases(i).ovr 
                REPORT "Test case failed " & INTEGER'IMAGE(i) SEVERITY FAILURE;
            WAIT FOR period-tp;
        END LOOP;
        ASSERT FALSE
            REPORT "No error found!" SEVERITY NOTE;
    END PROCESS;

END ARCHITECTURE;

CONFIGURATION tb_alu_conf OF tb_alu IS
    FOR testbench
    END FOR;
end tb_alu_conf;
