-- This project was to make a counter that counted to one minute
-- the current seconds was displayed on two seven segment displays
-- a button was used to reset the counters back to 00
-- another button was assigned to toggle the counters to count up or down

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Project1 is
port (reset, reverse, clk: in std_logic;
	seven_segment_tens, seven_segment_ones: out std_logic_vector(6 downto 0));
end Project1;

architecture sequential of Project1 is

constant D0 : std_logic_vector(6 downto 0):="1000000";
constant D1 : std_logic_vector(6 downto 0):="1111001";
constant D2 : std_logic_vector(6 downto 0):="0100100";
constant D3 : std_logic_vector(6 downto 0):="0110000";
constant D4 : std_logic_vector(6 downto 0):="0011001";
constant D5 : std_logic_vector(6 downto 0):="0010010";
constant D6 : std_logic_vector(6 downto 0):="0000010";
constant D7 : std_logic_vector(6 downto 0):="1111000";
constant D8 : std_logic_vector(6 downto 0):="0000000";
constant D9 : std_logic_vector(6 downto 0):="0010000";
constant DA : std_logic_vector(6 downto 0):="0001000";
constant DB : std_logic_vector(6 downto 0):="0000011";
constant DC : std_logic_vector(6 downto 0):="1000110";
constant DD : std_logic_vector(6 downto 0):="0100001";
constant DE : std_logic_vector(6 downto 0):="0000110";
constant DF : std_logic_vector(6 downto 0):="0001110";
constant DX : std_logic_vector(6 downto 0):="1111111";
signal segment_tens : std_logic_vector(6 downto 0);
signal segment_ones : std_logic_vector(6 downto 0);
signal count_tens : std_logic_vector(3 downto 0):= "0000";
signal count_ones : std_logic_vector(3 downto 0):= "0000";
-- signal divided_clk, pb1, pb2 : std_logic;
-- Warning: this will not work in ModelSim
signal rst, rvrs : std_logic;
signal divided_clk : std_logic := '0';
signal reverse_flag : std_logic := '1';

-- It is important to initialize value for ModelSim
begin
clock_divider: process (clk)
variable clk_count: integer:=0;
begin
if(clk'event and clk = '1') then
-- for simulation replace 12500000 with smaller number such as 2 or 4 to
-- minimize simulation time
 if clk_count = 50000000 then
	divided_clk <= not divided_clk;
	clk_count := 0;
 else
	clk_count := clk_count + 1;
 end if;
end if;
end process;
counter: process (divided_clk, rst,rvrs, reverse_flag)
begin
if (rvrs = '0') then
	if (reverse_flag = '1') then
		reverse_flag <= '0';
	else
		reverse_flag <= '0';
	end if;
end if;
if (rst = '0') then
	count_tens <= "0000";
	count_ones <= "0000";
elsif (divided_clk'event and divided_clk = '1' and reverse_flag = '1') then
 if (count_ones = "1001") then
	count_ones <= "0000";
	if (count_tens = "0101") then
		count_tens <= "0000";
	else
		count_tens <= "0001" + count_tens;
	end if;
 else
 count_ones <= "0001" + count_ones;
 end if;
elsif (divided_clk'event and divided_clk = '1' and reverse_flag = '0') then
	if (count_ones = "0000") then
		count_ones <= "1001";
		if (count_tens = "0000") then
			count_tens <= "0101";
		else
			count_tens <= count_tens - "0001";
		end if;
	else
		count_ones <= count_ones - "0001";
 end if;
end if;
end Process;
display: process (count_tens, count_ones)
begin
case count_tens is
when "0000" => segment_tens <= D0;
when "0001" => segment_tens <= D1;
when "0010" => segment_tens <= D2;
when "0011" => segment_tens <= D3;
when "0100" => segment_tens <= D4;
when "0101" => segment_tens <= D5;
when "0110" => segment_tens <= D6;
when "0111" => segment_tens <= D7;
when "1000" => segment_tens <= D8;
when "1001" => segment_tens <= D9;
when "1010" => segment_tens <= DA;
when "1011" => segment_tens <= DB;
when "1100" => segment_tens <= DC;
when "1101" => segment_tens <= DD;
when "1110" => segment_tens <= DE;
when "1111" => segment_tens <= DF;
when others => segment_tens <= DX;
end case;

case count_ones is
when "0000" => segment_ones <= D0;
when "0001" => segment_ones <= D1;
when "0010" => segment_ones <= D2;
when "0011" => segment_ones <= D3;
when "0100" => segment_ones <= D4;
when "0101" => segment_ones <= D5;
when "0110" => segment_ones <= D6;
when "0111" => segment_ones <= D7;
when "1000" => segment_ones <= D8;
when "1001" => segment_ones <= D9;
when "1010" => segment_ones <= DA;
when "1011" => segment_ones <= DB;
when "1100" => segment_ones <= DC;
when "1101" => segment_ones <= DD;
when "1110" => segment_ones <= DE;
when "1111" => segment_ones <= DF;
when others => segment_ones <= DX;
end case;
end process;
--Signal Assignment
rst <= reset;
rvrs <= reverse;
seven_segment_ones <= segment_ones;
seven_segment_tens <= segment_tens;
end architecture sequential;
