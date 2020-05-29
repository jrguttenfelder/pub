LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entity definition for Full Adder
ENTITY fullAdder IS
    PORT (a, b, cin: IN STD_LOGIC;
          sum, cout: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE dataflow OF fullAdder IS
BEGIN
    sum <= a xor b xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);
END ARCHITECTURE;

