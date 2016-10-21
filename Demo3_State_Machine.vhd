-- This program has a four state machine
-- A button is used to traverse the states
-- Another button is used to reset the state to zero
-- Four LEDs were used to represent the current state on the machine
-- The ones column will range from 0-9 (0000 to 10001) and then trigger a response on the
-- 10's column which will go to 5 (0101)

library ieee;
use ieee.std_logic_1164.all;
entity state_machine is
port (
pb_1, reset : in std_logic;
 led_out : out std_logic_vector(3 downto 0)
 );
end entity state_machine;
architecture sequential of state_machine is
type state_type is (S0, S1, S2, S3);
signal state : state_type;
begin
-- Process 1: Determine next state based on current state and the input.
process (pb_1, reset)
begin
if (reset = '0')then -- Active low async reset.
state <= S0;
elsif (rising_edge(pb_1))then -- not else if!
case state is
when s0=>
state <= s1;
when s1=>
state <= s2;
when s2=>
state <= s3;
when s3=>
state <= s0;
end case;
end if;
end process;
-- Process 2: Determine output based on current state (Moore machine).
process (state)
begin
case state is
when s0=> led_out <= "1000";
when s1=> led_out <= "0100";
when s2=> led_out <= "0010";
when s3=> led_out <= "0001";
end case;
end process;
end architecture sequential;
