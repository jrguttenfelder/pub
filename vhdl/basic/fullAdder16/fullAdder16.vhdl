library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


-- entity definition for 16-bit full adder
entity FullAdder16Bit is
    port( A,B: in std_logic_vector(15 downto 0); -- Two 16 Bit inputs
          Cin: in std_logic;
          Sum: out std_logic_vector(15 downto 0); -- 16 Bit Output
          Cout: out std_logic);
end FullAdder16Bit;

-- Behavioral design of 16 bit FA
architecture behavior of FullAdder16Bit is
begin --architecture
    process (A,B,Cin)
        variable carry: std_logic;
    begin --process
        carry := Cin;
        for i in 0 to 15 loop
            carry:= (A(i) and B(i)) or (carry and (a(i) or b(i)));
        end loop;
        Sum <= A + B + Cin;
        Cout <= carry;
    end process;
end behavior;

