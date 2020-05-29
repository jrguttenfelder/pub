library ieee;
use ieee.std_logic_1164.all;

-- test bench entity definition
entity tb_register16 is
end tb_register16;

-- test bench structure
architecture tb_reg16_structure of tb_register16 is
    
    -- define 16-bit Register component
    component register16
        port (d : in std_logic_vector(15 downto 0);
              clk,reset : in std_logic;
              q : out std_logic_vector(15 downto 0)
        );
    end component;

    -- define signals to use for 16-bit Register
    signal d : std_logic_vector(15 downto 0) := (OTHERS => '0');
    signal reset : std_logic := '0';
    signal clk : std_logic := '1';
    signal q : std_logic_vector(15 downto 0) := (OTHERS => '0');

begin
    DUT : register16 port map (d,clk,reset,q);
    
    -- cycle clock signal every 10 ns
    clk <= not clk after 10 ns;
    process
    begin
        -- test reset operation
        reset <= '1';
        wait for 20 ns;
        
        -- clear reset
        reset <= '0';
        
        -- change input value
        d <= "0000000000000001";
        wait for 20 ns;
        
        -- change intput value
        d <= "0101010101010101";
        wait for 20 ns;
        
        -- change input value
        d <= "1010101010101010";
        wait for 20 ns;
        
        -- change input value
        d <= (OTHERS => '1');
        wait for 20 ns;
        
        -- change input value
        d <= (OTHERS => '0');
        wait for 20 ns;

    end process;
end tb_reg16_structure;
