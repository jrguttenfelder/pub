library ieee;
use ieee.STD_LOGIC_1164.ALL;

-- 2 to 1 multiplexer definition
entity Multiplexer2to1 IS
    port ( A, B: IN std_logic;
           Sel: IN std_logic; -- select line for the multiplexer.
           MuxOut: OUT std_logic); -- output the selected input (A for Sel=0)
end Multiplexer2to1;

-- 2 to 1 multiplexer behavior
architecture behavior of Multiplexer2to1 is
begin
    process(A, B,Sel)
    begin
        if (Sel = '0') then MuxOut <= A;
        elsif (Sel = '1') then MuxOut <= B;
        end if;
    end process;
end behavior;

