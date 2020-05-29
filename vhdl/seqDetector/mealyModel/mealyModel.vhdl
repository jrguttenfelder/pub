library ieee;
use ieee.std_logic_1164.all;

entity seqdetector is
    port (clk, input, reset : in std_logic;
          output : out std_logic -- '1' indicates that the pattern is detected
    );
end seqdetector;

architecture seqdet of seqdetector is
    type states is (s0,s1,s2,s3,s4); -- states in the sequence detecting FSM
    signal present_state : states := s0; -- state prior to clock edge: getting ready to move
    signal next_state : states := s0; -- state after clock edge: new state
begin
    
    p1: process (clk, reset)
    begin
        if (reset = '1') then -- asynchronous reset: resets anytime
            present_state <= s0; -- initialize the FSM: move to s0
        elsif (clk'event and clk = '1') then -- when clock has rising edge
            present_state <= next_state; -- move to the new state as determined below
        end if;
    end process;

    p2: process (present_state, input)
    begin
        case present_state is
        when s0 =>
            if (input = '1') then
                output <= '0';
                next_state <= s1;
            else
                output <= '0';
                next_state <= s0;
            end if;
        when s1 =>
            if (input = '0') then
                output <= '0';
                next_state <= s2;
            else
                output <= '0';
                next_state <= s1;
            end if;
        when s2 =>
            if (input = '1') then
                output <= '0';
                next_state <= s3;
            else
                output <= '0';
                next_state <= s0;
            end if;
        when s3 =>
            if ( input = '0' ) then
                output <= '1';
                next_state <= s4;
            else
                output <= '0';
                next_state <= s1;
            end if;
        when s4 =>
            if ( input = '1' ) then
                output <= '0';
                next_state <= s3;
            else
                output <= '0';
                next_state <= s0;
            end if;
        when others => NULL;
    end case;
    end process;

end seqdet;
