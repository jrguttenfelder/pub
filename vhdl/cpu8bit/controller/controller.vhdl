LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- CPU controller
ENTITY controller IS
    PORT (clk : IN STD_LOGIC;
          enable : IN STD_LOGIC;
          eq, gt, za, zb, ovr : IN STD_LOGIC;
          opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
          incPC, loadPC, loadIR,
          loadA, loadB, loadC, loadOut : OUT STD_LOGIC;
          cSel, imSel : OUT STD_LOGIC;
          weDM : OUT STD_LOGIC;
          aluOpcode : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END ENTITY;

-- 1. instruction fetch
--      increment PC
-- 2. instruction decode
--      set control flags
-- 3. execute
--      wait X clks to complete

ARCHITECTURE behavior OF controller IS
    TYPE state IS (disabled, fetch, decode, execute, halt);
    SIGNAL curState, nxtState : state;
    ATTRIBUTE enum_encoding : STRING;
    ATTRIBUTE enum_encoding OF state : TYPE IS "sequential";
    TYPE ControlFlags IS ARRAY (6 DOWNTO 0) OF STD_LOGIC;
    
    FUNCTION getControlFlags(opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
                             eq, gt, za, zb, ovr : STD_LOGIC) 
    RETURN ControlFlags IS
        VARIABLE flags : ControlFlags;
    BEGIN
        flags := (OTHERS => '0');
        
        -- ALU operations
        IF (opcode(5) = '0') THEN
            -- loadC = '1'
            flags := "0010000";
        -- Non-ALU operations
        ELSE
            CASE opcode(4 DOWNTO 0) IS
                --
                -- Register & Memory Operations
                --
                
                -- LDA
                WHEN "00000" =>
                    -- loadA = '1'
                    flags := "0000100";
                -- LDB
                WHEN "00001" =>
                    -- loadB = '1'
                    flags := "0001000";
                -- LIC
                WHEN "00010" =>
                    -- cSel = '1' and loadC = '1'
                    flags := "0010001";
                -- STC
                WHEN "00011" =>
                    -- weDM = '1'
                    flags := "1000000"; 
        
                --
                -- Control Operations
                --
                
                -- JEQ
                WHEN "01010" =>
                    -- loadPC = eq
                    flags(1) := eq;
                -- JGT
                WHEN "01011" =>
                    -- loadPC = gt
                    flags(1) := gt;
                -- JO
                WHEN "01100" =>
                    -- loadPC = ovr
                    flags(1) := ovr;
                -- JZA
                WHEN "01101" =>
                    -- loadPC = za
                    flags(1) := za;
                -- JZB
                WHEN "01110" =>
                    -- loadPC = zb
                    flags(1) := zb;
                -- JMP
                WHEN "01111" =>
                    -- loadPC = 1
                    flags := "0000010";
                    
                --
                -- Output Operations
                --
                
                -- RDM
                WHEN "11000" =>
                    -- loadOut = '1'
                    flags := "0100000";
                    
                --
                -- All Other Operations (including NOP and HLT)
                --
                WHEN OTHERS =>
                    flags := (OTHERS => '0');
                    null;
            END CASE;
        END IF;
        
        RETURN flags;
    
    END FUNCTION;
    
BEGIN
    PROCESS (clk, enable)
    BEGIN
        IF (enable = '0') THEN
            curState <= disabled;
        ELSIF (clk'EVENT AND clk='1') THEn
            curState <= nxtState;
        END IF;
    END PROCESS;
    
    PROCESS (curState, enable, opcode, eq, gt, za, zb, ovr)
        VARIABLE ctrlFlags : ControlFlags;
    BEGIN
    
        CASE curState IS
            WHEN disabled =>
                incPC <= '0';
                loadIR <= '0';
                ctrlFlags := (OTHERS => '0');
                nxtState <= fetch;
            WHEN fetch =>
                incPC <= '1';
                loadIR <= '1';
                nxtState <= decode;
            WHEN decode =>
                incPC <= '0';
                loadIR <= '0';
                aluOpcode <= opcode(4 DOWNTO 0);
                ctrlFlags := getControlFlags(opcode, eq, gt, za, zb, ovr);
                nxtState <= execute;
            WHEN execute =>
                incPC <= '0';
                loadIR <= '0';
                IF (opcode = "101001") THEN
                    nxtState <= halt;
                ELSE
                    nxtState <= fetch;
                END IF;
            WHEN OTHERS => -- halted state
                incPC <= '0';
                loadIR <= '0';
                ctrlFlags := (OTHERS => '0');
                nxtState <= halt;
        END CASE;
        
        imSel <= NOT enable;
        cSel <= ctrlFlags(0);
        loadPC <= ctrlFlags(1);
        loadA <= ctrlFlags(2);
        loadB <= ctrlFlags(3);
        loadC <= ctrlFlags(4);
        loadOut <= ctrlFlags(5);
        weDM <= ctrlFlags(6);
        
    END PROCESS;
END ARCHITECTURE;
