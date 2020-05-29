library ieee;
use ieee.std_logic_1164.all;

-- entity definition: 2-port AND gate
entity and2 is
    port (in1, in2 : in std_logic;
          out1     : out std_logic);
end and2;

-- behavior of 2-port AND gate
architecture behavior of and2 is
begin
    out1 <= in1 and in2; 
end behavior;
