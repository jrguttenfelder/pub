library ieee;
use ieee.std_logic_1164.ALL;

entity decoder2to4 is
    port (A, B : in std_logic;
          Y0,Y1,Y2,Y3 : out std_logic);
end decoder2to4;

architecture behavior of decoder2to4 is
begin
    process (A, B)
        variable BA_vector : std_logic_vector(1 downto 0) := "00";
    begin
        BA_vector := B & A;
        case (BA_vector) is
            when "00" => Y0 <= '1'; 
                Y1 <= '0';
                Y2 <= '0';
                Y3 <= '0';
            when "01" => Y0 <= '0';
                Y1 <= '1';
                Y2 <= '0';
                Y3 <= '0';
            when "10" => Y0 <= '0';
                Y1 <= '0';
                Y2 <= '1';
                Y3 <= '0';
            when "11" => Y0 <= '0';
                Y1 <= '0';
                Y2 <= '0';
                Y3 <= '1';
            when others => Y0 <= '0';
                Y1 <= '0';
                Y2 <= '0';
                Y3 <= '0';
        end case;
    end process;
end behavior;

