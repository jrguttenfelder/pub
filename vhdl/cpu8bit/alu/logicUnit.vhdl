LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY logicUnit IS
    GENERIC (N: INTEGER := 16); 
    PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
          c : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          eq, gt, za, zb : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE dataflow of logicUnit IS
    SIGNAL a_signed, b_signed : SIGNED(N-1 DOWNTO 0);
BEGIN
    -- Calculate logic result based on opcode
    WITH opcode SELECT
        c <= a AND b  WHEN "000",
             a OR b   WHEN "001",
             a NAND b WHEN "010",
             a NOR b  WHEN "011",
             NOT a    WHEN "100",
             NOT b    WHEN "101",
             a XOR b  WHEN "110",
             a XNOR b WHEN OTHERS;
             
    -- convert to signed numbers
    a_signed <= signed(a);
    b_signed <= signed(b);

    -- Set flag if A is equal to B
    eq <= '1' WHEN a_signed = b_signed ELSE '0';
    
    -- Set flag if A is greater than B
    gt <= '1' WHEN a_signed > b_signed ELSE '0';
    
    -- Set flag if A is zero
    za <= '1' WHEN a_signed=0 ELSE '0';
    
    -- Set flag if B is zero
    zb <= '1' WHEN b_signed=0 ELSE '0';
END ARCHITECTURE;
