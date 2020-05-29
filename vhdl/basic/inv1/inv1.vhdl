library ieee;
use ieee.std_logic_1164.ALL;

-- entity definition: 1-port NOT gate
entity inv1 is
    port ( in1 : in std_logic;      -- 1 input: in1
           out1 : out std_logic);   -- 1 output: out1
end inv1;

-- behaviour of 1-port NOT gate
architecture behavior of inv1 is
begin
    out1 <= not in1; -- invert the value of in1 and store in out1
end behavior;

