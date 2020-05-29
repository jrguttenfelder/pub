LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tb_controller IS
END ENTITY;

ARCHITECTURE testbench OF tb_controller IS
    -- Design under test
    COMPONENT controller IS
        PORT (clk : IN STD_LOGIC;
              enable : IN STD_LOGIC;
              eq, gt, za, zb, ovr : IN STD_LOGIC;
              opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
              incPC, loadPC, loadIR,
              loadA, loadB, loadC, loadOut : OUT STD_LOGIC;
              cSel, imSel : OUT STD_LOGIC;
              weDM : OUT STD_LOGIC;
              aluOpcode : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
    END COMPONENT;

    SIGNAL clk, enable : STD_LOGIC := '0';
    SIGNAL eq, gt, za, zb, ovr : STD_LOGIC := '0';
    SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL incPC, loadPC, loadIR, loadA, loadB, loadC, loadOut : STD_LOGIC;
    SIGNAL cSel, imSel : STD_LOGIC;
    SIGNAL weDM : STD_LOGIC;
    SIGNAL aluOpcode : STD_LOGIC_VECTOR(4 DOWNTO 0);
    
    TYPE testcase IS RECORD
        enable : STD_LOGIC;
        eq, gt, za, zb, ovr : STD_LOGIC;
        opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
        incPC, loadPC, loadIR, 
        loadA, loadB, loadC, loadOut,
        cSel, imSel, weDM : STD_LOGIC;
    END RECORD;
    
    TYPE testcases IS ARRAY (1 TO 32) OF testcase;
    CONSTANT testCommands : testcases := (
        -- Disabled
        ('0', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "000000", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '1', '0'), -- cSel, imSel, weDM

        -- ADD
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "000000", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- MUL
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "000001", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- SUB
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "000010", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- DIV
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "000011", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- AND
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001000", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- OR
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001001", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- NAND
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001010", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- NOR
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001011", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- NOTA
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001100", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- NOTB
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001101", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- XOR
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001110", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- XNOR
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "001111", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- RSHFT
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "010000", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- LSHFT
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "010001", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- LDA
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "100000", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '1', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- LDB
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "100001", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '1', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- LIC
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "100010", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '1', '0', -- loadA-C, loadOut
         '1', '0', '0'), -- cSel, imSel, weDM
    
        -- STC
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "100011", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '1'), -- cSel, imSel, weDM
         
        -- NOP
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "101000", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JEQ (true)
        ('1', -- enable
         '1', '0', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101010", -- opcode
         '0', '1', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JEQ (false)
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101010", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JGT (true)
        ('1', -- enable
         '0', '1', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101011", -- opcode
         '0', '1', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JGT (false)
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101011", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JO (true)
        ('1', -- enable
         '0', '0', '0', '0', '1', -- ALU flags (eq, gt, za, zb, ovr)
         "101100", -- opcode
         '0', '1', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JO (false)
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101100", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM

        -- JZA (true)
        ('1', -- enable
         '0', '0', '1', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101101", -- opcode
         '0', '1', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JZA (false)
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101101", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM

        -- JZB (true)
        ('1', -- enable
         '0', '0', '0', '1', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101110", -- opcode
         '0', '1', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JZB (false)
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101110", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- JMP
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags (eq, gt, za, zb, ovr)
         "101111", -- opcode
         '0', '1', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '0', -- loadA-C, loadOut
         '0', '0', '0'), -- cSel, imSel, weDM
         
        -- RDM
        ('1', -- enable
         '0', '0', '0', '0', '0', -- ALU flags
         "111000", -- opcode
         '0', '0', '0', -- incPC, loadPC, loadIR
         '0', '0', '0', '1', -- loadA-C, loadOut
         '0', '0', '0') -- cSel, imSel, weDM
    );
    
BEGIN
    DUT : controller PORT MAP (
        clk, enable, 
        eq, gt, za, zb, ovr,
        opcode,
        incPC, loadPC, loadIR, loadA, loadB, loadC, loadOut,
        cSel, imSel,
        weDM,
        aluOpcode );
                                         
    clk <= NOT clk AFTER 10 ns;
    
    PROCESS
    BEGIN
        enable <= '0';
        WAIT FOR 100 ns;
        
        FOR i IN testCommands'RANGE LOOP
            enable <= testCommands(i).enable;
            eq <= testCommands(i).eq;
            gt <= testCommands(i).gt;
            za <= testCommands(i).za;
            zb <= testCommands(i).zb;
            ovr <= testCommands(i).ovr;
            opcode <= testCommands(i).opcode;
            -- wait for fetch, decode, execute
            WAIT FOR 60 ns;
            ASSERT incPC = testCommands(i).incPC 
                   AND loadPC = testCommands(i).loadPC
                   AND loadIR = testCommands(i).loadIR
                   AND loadA = testCommands(i).loadA
                   AND loadB = testCommands(i).loadB
                   AND loadC = testCommands(i).loadC
                   AND loadOut = testCommands(i).loadOut
                   AND cSel = testCommands(i).cSel
                   AND imSel = testCommands(i).imSel
                   AND weDM = testCommands(i).weDM
                   REPORT "Test case failed!" SEVERITY FAILURE;
        END LOOP;

        -- report no error
        ASSERT FALSE
            REPORT "No error found!" SEVERITY NOTE;
    END PROCESS;

END ARCHITECTURE;

CONFIGURATION tb_controller_conf OF tb_controller IS
    FOR testbench
    END FOR;
end tb_controller_conf;
