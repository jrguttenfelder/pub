library ieee;
use ieee.std_logic_1164.ALL;

-- 3 to 8 decoder definition
entity decoder3to8 is
    port ( A, B, C : in std_logic;
           Y0,Y1,Y2,Y3,Y4,Y5,Y6,Y7 : out std_logic);
end decoder3to8;

-- 3 to 8 decoder behavior
architecture behavior of decoder3to8 is
begin
    process (A, B, C)
        variable CBA_vector : std_logic_vector (2 downto 0) := "000";
    begin
        CBA_vector := C & B & A;
        if (CBA_vector = "000") then Y0 <= '1';
                                else Y0 <= '0';
        end if;
        if (CBA_vector = "001") then Y1 <= '1';
                                else Y1 <= '0';
        end if;
        if (CBA_vector = "010") then Y2 <= '1';
                                else Y2 <= '0';
        end if;
        if (CBA_vector = "011") then Y3 <= '1';
                                else Y3 <= '0';
        end if;
        if (CBA_vector = "100") then Y4 <= '1';
                                else Y4 <= '0';
        end if;
        if (CBA_vector = "101") then Y5 <= '1';
                                else Y5 <= '0';
        end if;
        if (CBA_vector = "110") then Y6 <= '1';
                                else Y6 <= '0';
        end if;
        if (CBA_vector = "111") then Y7 <= '1';
                                else Y7 <= '0';
        end if;
    end process;
end behavior;
