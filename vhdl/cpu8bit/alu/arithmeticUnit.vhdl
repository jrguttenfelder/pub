LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY arithmeticUnit IS
    GENERIC (N: INTEGER := 16);
    PORT (a, b : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          opcode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
          c : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0);
          ovr : OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE dataflow of arithmeticUnit  IS
    SIGNAL a_signed, b_signed : SIGNED(N-1 DOWNTO 0);
    
    SIGNAL add_sub_signed : SIGNED(N-1 DOWNTO 0);
    SIGNAL add_sub_ovr : STD_LOGIC;

    SIGNAL mult_div_signed : SIGNED(N*2 - 1 DOWNTO 0);
    SIGNAL mult_div_ovr : STD_LOGIC;
    
BEGIN
    -- convert a and b to signed values
    a_signed <= signed(a);
    b_signed <= signed(b);
    
    -- add/sub logic
    add_sub_signed <= a_signed + b_signed WHEN opcode="00"
                      ELSE a_signed - b_signed WHEN opcode="10"
                      ELSE (OTHERS => '0');
    
    -- add/sub overflow occurs when 
    -- 1. sign(a) = sign(b) but sign(a) != sign(a+b)
    -- 2. a < b and a-b > 0
    -- 3. a > b and a-b < 0
    add_sub_ovr <= '1' WHEN a_signed(N-1)=b_signed(N-1) AND a_signed(N-1)/=add_sub_signed(N-1) AND opcode="00" -- case 1
                   ELSE '1' WHEN a_signed < b_signed AND add_sub_signed > 0 AND opcode="10"
                   ELSE '1' WHEN a_signed > b_signed AND add_sub_signed < 0 AND opcode="10"
                   ELSE '0';
               
    -- mul/div logic
    mult_div_signed <= a_signed * b_signed WHEN opcode="01"
                       ELSE resize(a_signed / b_signed, mult_div_signed'LENGTH) WHEN opcode="11" AND b_signed/=0
                       ELSE (OTHERS => '0');

    -- mul/div overflow ocurrs when 
    --- 1. two positive numbers produce a negative number 
    --  2. two negative numbers produce a negative number
    --  3. a positive and a negative number produce a postive number
    --  4. division by zero
    --  5. the resulting value extends into higher order bits
    mult_div_ovr <= '1' WHEN a_signed(N-1)=b_signed(N-1) AND mult_div_signed(N-1)='1' -- case 1 and 2
                    ELSE '1' WHEN a_signed(N-1)/=b_signed(N-1) AND mult_div_signed(N-1)='0' -- case 3
                    ELSE '1' WHEN b_signed=0 AND opcode="11" -- case 4
                    ELSE '1' WHEN mult_div_signed(N*2-2 DOWNTO N) > 0 -- case 5
                    ELSE '0';
    
    -- copy output to c
    WITH opcode SELECT
        c <= std_logic_vector(add_sub_signed) WHEN "00"|"10",
             std_logic_vector(mult_div_signed(N-1 DOWNTO 0)) WHEN OTHERS;

    -- set overflow flag
    WITH opcode SELECT
        ovr <= add_sub_ovr WHEN "00"|"10",
               mult_div_ovr WHEN OTHERS;
               
END ARCHITECTURE;
