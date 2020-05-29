library ieee;
use ieee.std_logic_1164.all;

-- entity definition for 16-bit Register
-- inputs are: D (data in), CLK (clock signal), and RESET (reset signal)
-- output is: Q (saved input value)
entity register16 is
    port (d : in std_logic_vector(15 downto 0);
          clk, reset : in std_logic;
          q : out std_logic_vector(15 downto 0)
    );
end register16;

-- structure definition of 16-bit register
architecture reg16_structure of register16 is
    
    -- define 4-bit Register component
    component register4
        port (d : in std_logic_vector(3 downto 0);
              clk,reset : in std_logic;
              q : out std_logic_vector(3 downto 0)
        );
    end component;
    
begin
    reg1: register4 PORT MAP (d(3 downto 0), clk, reset, q(3 downto 0));
    reg2: register4 PORT MAP (d(7 downto 4), clk, reset, q(7 downto 4));
    reg3: register4 PORT MAP (d(11 downto 8), clk, reset, q(11 downto 8));
    reg4: register4 PORT MAP (d(15 downto 12), clk, reset, q(15 downto 12));
end reg16_structure;

