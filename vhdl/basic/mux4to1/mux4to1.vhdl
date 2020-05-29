library ieee;
use ieee.std_logic_1164.all;

-- 4 to 1 multiplexer definition
entity mux4to1 is
    port ( D : in std_logic_vector (3 downto 0); -- 4 bit data
           Sel : in std_logic_vector (1 downto 0); -- 2 bit select line
           Y : out std_logic); -- output data value
end mux4to1;

-- 4 to 1 multiplexer behavior
architecture behavior of mux4to1 is
begin
    with Sel select
    Y <= D(0) when "00",
         D(1) when "01",
         D(2) when "10",
         D(3) when others;
end behavior;

