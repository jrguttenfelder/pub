LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- CPU definition
-- clk - Clock signal
-- enable - Start executing program
-- reset - Reset registers
-- weIM - Enable Instruction Memory Writing (loading)
-- codeAddress - Address for program instruction (loading)
-- codeIn - Instruction to be loaded (loading)
-- dataOut - Output from program execution
ENTITY cpu IS
    GENERIC (ADDRESS_SIZE: INTEGER := 10; DATA_SIZE: INTEGER := 16);
    PORT (clk, enable, reset : IN STD_LOGIC;
          weIM : IN STD_LOGIC;
          codeAddress : IN STD_LOGIC_VECTOR(ADDRESS_SIZE-1 DOWNTO 0);
          codeIn : IN STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);
          dataOut : OUT STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0));
END ENTITY;

ARCHITECTURE structure OF cpu IS

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

    COMPONENT alu IS
        GENERIC (N : INTEGER := 16);
        PORT (a, b: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              opcode: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
              c: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              eq, gt, za, zb, ovr : OUT STD_LOGIC);
    END COMPONENT;
    
    COMPONENT memory IS 
        GENERIC (M: INTEGER := 16; N: INTEGER := 16);
        PORT (clk : IN STD_LOGIC;
              writeEnable : IN STD_LOGIC;
              address : IN STD_LOGIC_VECTOR(M-1 DOWNTO 0);
              dataIn : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              dataOut : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
    END COMPONENT;
    
    COMPONENT registerN IS
        GENERIC (N: INTEGER := 16);
        PORT (clk, load, reset : IN STD_LOGIC;
              d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
    END COMPONENT;
    
    COMPONENT pc IS
        GENERIC (N: INTEGER := 16);
        PORT (clk, inc, load, reset : IN STD_LOGIC;
              d : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              q : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
    END COMPONENT;
    
    COMPONENT mux2to1 IS
        GENERIC (N: INTEGER := 16);
        PORT (x, y : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              sel : IN STD_LOGIC;
              z : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
    END COMPONENT;
    
    SIGNAL opcode : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL operand_data : STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);
    SIGNAL operand_address : STD_LOGIC_VECTOR(ADDRESS_SIZE-1 DOWNTO 0);
    SIGNAL loadA, loadB, loadC, loadIR, loadOut : STD_LOGIC;
    SIGNAL aData, bData, cData, cDataIn, dmOut, aluOut : STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);

    SIGNAL incPC, loadPC : STD_LOGIC;
    SIGNAL nxtInstruction, curInstruction : STD_LOGIC_VECTOR(DATA_SIZE-1 DOWNTO 0);
    SIGNAL execAddress, imAddress : STD_LOGIC_VECTOR(ADDRESS_SIZE-1 DOWNTO 0);

    SIGNAL cSel, imSel : STD_LOGIC;
    SIGNAL weDM : STD_LOGIC;
    SIGNAL aluOpcode : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL eq, gt, za, zb, ovr : STD_LOGIC;
    
BEGIN
    -- Determine opcode and operand for current instruction
    opcode <= curInstruction(DATA_SIZE-1 DOWNTO DATA_SIZE-6);
    operand_data <= "000000" & curInstruction(9 DOWNTO 0);
    operand_address <= curInstruction(9 DOWNTO 0);

    -- Registers
    registerA : registerN GENERIC MAP (DATA_SIZE) PORT MAP (clk, loadA, reset, dmOut, aData);
    registerB : registerN GENERIC MAP (DATA_SIZE) PORT MAP (clk, loadB, reset, dmOut, bData);
    registerC : registerN GENERIC MAP (DATA_SIZE) PORT MAP (clk, loadC, reset, cDataIn, cData);
    registerOut : registerN GENERIC MAP (DATA_SIZE) PORT MAP (clk, loadOut, reset, dmOut, dataOut);

    -- Mux for Register C
    regCmux : mux2to1 GENERIC MAP (DATA_SIZE) PORT MAP (aluOut, operand_data, cSel, cDataIn);
    
    -- Data Memory
    dataMemory : memory GENERIC MAP (ADDRESS_SIZE, DATA_SIZE) PORT MAP (clk, weDM, operand_address, cData, dmOut);
    
    -- Instruction Unit
    programCounter : pc GENERIC MAP (ADDRESS_SIZE) PORT MAP (clk, incPC, loadPC, reset, operand_address, execAddress);
    instructionMux : mux2to1 GENERIC MAP (ADDRESS_SIZE) PORT MAP (execAddress, codeAddress, imSel, imAddress);
    instructionMemory : memory GENERIC MAP (ADDRESS_SIZE, DATA_SIZE) PORT MAP (clk, weIM, imAddress, codeIn, nxtInstruction);
    instructionRegister : registerN GENERIC MAP (DATA_SIZE) PORT MAP (clk, loadIR, reset, nxtInstruction, curInstruction);
    
    -- Control Unit
    controlUnit : controller PORT MAP (clk, enable, 
                                       eq, gt, za, zb, ovr, 
                                       opcode,
                                       incPC, loadPC, 
                                       loadIR, 
                                       loadA, loadB, loadC, loadOut,
                                       cSel, imSel,
                                       weDM,
                                       aluOpcode);

    -- Arithmetic Logic Unit
    alUnit : alu GENERIC MAP (DATA_SIZE) PORT MAP (aData, bData, aluOpcode, aluOut, 
                                                   eq, gt, za, zb, ovr);

END ARCHITECTURE;
