-- This lab programmed an Or gate
-- both inputs were assigned to buttons so either would light up the an LED on the FPGA board

library ieee;
use ieee.std_logic_1164.all;
entity DemoLab1 is
 port(
 pb1, pb2 : in std_logic;
 led : out std_logic );
end DemoLab1;
architecture behave of DemoLab1 is
begin
 led <= (not pb1) or (not pb2);
end behave;
