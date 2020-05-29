library ieee;
use ieee.std_logic_1164.ALL;

-- entity definition: 8-port AND gate
entity and8 is
    port ( D : in std_logic_vector (7 downto 0);  -- 8 inputs
           out1 : out std_logic);    -- 1 output: out1
end and8;

-- behaviour of 8-port AND gate
architecture behavior of and8 is
begin
    -- logical AND all elements within D
    out1 <= D(0) 
            and D(1)
            and D(2)
            and D(3)
            and D(4)
            and D(5)
            and D(6)
            and D(7);
end behavior;
