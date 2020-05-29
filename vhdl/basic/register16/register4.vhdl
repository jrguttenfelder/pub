library ieee;
use ieee.std_logic_1164.all;

-- entity definition for 4-bit Register
-- inputs are: D (data in), CLK (clock signal), and RESET (reset signal)
-- output is: Q (saved input value)
entity register4 is
    port (d : in std_logic_vector(3 downto 0);
          clk,reset : in std_logic;
          q : out std_logic_vector(3 downto 0)
    );
end register4;

-- behavior definition of 4-bit Register
architecture behavior of register4 is
begin
    -- execute process when clk changes
    process(clk)
    begin
        -- if clk has changed and the value is 1
        if( clk'event and clk = '1') then
            -- check if reset bit is set, if so set output to 0
            if (reset = '1') then
                q <= (OTHERS => '0');
            -- otherwise, set output to input value
            else
                q <= d;
            end if;
        end if;
    end process;
end behavior;

