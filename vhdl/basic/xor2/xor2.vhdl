library ieee;
use ieee.std_logic_1164.ALL;

-- entity definition: 2-port XOR gate
entity xor2 is
    port ( In1, In2 : in std_logic; -- 2 inputs: In1, In2
           Out1 : out std_logic);   -- 1 output: Out1
end xor2;

-- behaviour of 2-port XOR gate
architecture behavior of xor2 is
begin
    -- concurrent logic
    Out1 <= In1 xor In2; -- logical XOR of In1 and In2, store result in Out1
end behavior;

