LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY alu IS
    GENERIC (N : INTEGER := 16);
    PORT (a, b: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          opcode: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
          c: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          eq, gt, za, zb, ovr : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE behavior of alu IS
    COMPONENT arithmeticUnit IS
        GENERIC (N: INTEGER := 16);
        PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              opcode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
              c : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              ovr : OUT STD_LOGIC);
    END COMPONENT;
    
    COMPONENT logicUnit IS
        GENERIC (N: INTEGER := 16); 
        PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
              c : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              eq, gt, za, zb : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT barrelShifter IS
        PORT (a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
              b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
              dir : IN STD_LOGIC;
              c : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;
    
    SIGNAL au_out : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL lu_out : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL shift_out : STD_LOGIC_VECTOR(N-1 DOWNTO 0);
    SIGNAL overflow : STD_LOGIC;
    
BEGIN
    -- arithmetic unit port mapping
    AU : arithmeticUnit GENERIC MAP (N) PORT MAP (a, b, opcode(1 DOWNTO 0), au_out, overflow);
    
    -- logic unit port mapping
    LU : logicUnit GENERIC MAP (N) PORT MAP (a, b, opcode(2 DOWNTO 0), lu_out, eq, gt, za, zb);
    
    -- shifter unit port mapping
    Shifter : barrelShifter PORT MAP (a, b(3 DOWNTO 0), opcode(0), shift_out);
    
    -- determine output based on opcode mode
    WITH opcode(4 DOWNTO 3) SELECT
        c <= au_out WHEN "00",
             lu_out WHEN "01",
             shift_out WHEN OTHERS;
             
    -- set overflow flag when opcode mode uses AU
    ovr <= overflow WHEN opcode(4 DOWNTO 3) = "00" ELSE '0';

END ARCHITECTURE;
