library ieee;
use ieee.numeric_std.ALL;
Use ieee.std_logic_1164.ALL;

-- 8-bit comparator entity definition
entity comparator8 is
    Port ( a, b : in std_logic_vector (7 downto 0);
           AgtB, AltB, AeqB : out std_logic);
end comparator8;

-- 8-bit comparator behavior definition
architecture behavior of comparator8 is
begin
    process(a, b)
    begin
        -- a equal to b
        if (a=b) then
            AeqB <='1'; AltB <='0'; AgtB <='0';
        -- a less than b
        elsif (a<b) then
            AeqB <='0'; AltB <='1'; AgtB <='0';
        -- a greater than b
        elsif (a>b) then
            AeqB <='0'; AltB <='0'; AgtB <='1';
        end if;
    end process;
end behavior;

    
