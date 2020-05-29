LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- barrel shifter implementation
-- a : value to shift
-- b : the amount to shift 'a' by
-- dir : 0=right shift, 1=left shift
-- c : shifted output
ENTITY barrelShifter IS
    PORT (a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
          b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
          dir : IN STD_LOGIC;
          c : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE behavior OF barrelShifter IS
    -- using N to 1 multiplexer to create barrel shifter
    COMPONENT muxNto1 IS
        GENERIC (N: INTEGER := 16);
        PORT (x : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
              sel : IN INTEGER RANGE 0 TO N-1;
              y : OUT STD_LOGIC);
    END COMPONENT;
    
    -- array of 15 integers with each integer being in the range from 0 to 15
    TYPE integerArray IS ARRAY (0 TO 15) OF INTEGER RANGE 0 TO 15;
    SIGNAL shiftArray : integerArray;
BEGIN

    -- create 16 multiplexers and use shiftArray to select which bit to output
    gen: FOR i IN 0 TO 15 GENERATE
        mux_i : muxNto1 GENERIC MAP (16) PORT MAP(a, shiftArray(i), c(i));
    END GENERATE;
        
    -- create process to calculate the value to shift each multiplexer output
    PROCESS (b, dir)
        VARIABLE temp : INTEGER RANGE -30 TO 30;
        VARIABLE b_int : INTEGER RANGE 0 TO 15;
    BEGIN
        b_int := to_integer(UNSIGNED(b));
        -- for each multiplexer, determine which bit should be selected
        FOR i IN 0 TO 15 LOOP
            IF dir = '1' THEN
                -- left shift, so substract 'b' from index
                temp := i - b_int;
                -- ensure that value is witin valid range (0-15)
                IF temp < 0 THEN
                    temp := temp + 16;
                END IF;
            ELSE
                -- right shift, so add 'b' to index
                temp := i + b_int;
                -- ensure that value is within valid range (0-15)
                IF temp >= 16 THEN
                    temp := temp - 16;
                END IF;
            END IF;
            -- store result into shiftArray
            shiftArray(i) <= temp;
        END LOOP;
    END PROCESS;

END ARCHITECTURE;
