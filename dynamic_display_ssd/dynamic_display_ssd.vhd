library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity dynamic_display_ssd is
port(
clk: in std_logic;
X: in std_logic_vector(3 downto 0);
AN: out std_logic_vector(3 downto 0); -- Digits
F: out std_logic_vector(6 downto 0) );
end dynamic_display_ssd;

architecture arch of dynamic_display_ssd is
constant N: integer :=17; -- 2^^15=32768
signal q_reg, q_next: unsigned(N-1 downto 0);
signal sel: std_logic_vector(1 downto 0);
signal hex: std_logic_vector(3 downto 0);
-- 12MHz/(2^15)=366.21Hz ; 2^^15=32768
begin
-- register
process(clk)
begin
if(clk'event and clk='1') then
q_reg <= q_next;
end if;
end process;
-- next-state logic for the counter
q_next <= q_reg + 1;
-- 2 MSBs of counter to control 4X1 multiplex and 2x4 Decoder
sel <= std_logic_vector(q_reg(N-1 downto N-2));
process(sel, X) -- 2x4 Decoder & 4x1 Mux
begin
case sel is
when "00" =>
an <= "0001"; hex <= X;
when "01" =>
an <= "0010"; hex <= X+1;
when "10" =>
an <= "0100"; hex <= X+2;
when others =>
an <= "1000"; hex <= X+3;
end case;
end process;
-- hex-to-7-segment led decoding
with hex select
F(6 downto 0) <=
"0000001" when "0000",
"1001111" when "0001",
"0010010" when "0010",
"0000110" when "0011",
"1001100" when "0100",
"0100100" when "0101",
"0100000" when "0110",
"0001111" when "0111",
"0000000" when "1000",
"0000100" when "1001",
"0001000" when "1010", --a
"1100000" when "1011", --b
"0110001" when "1100", --c
"1000010" when "1101", --d
"0110000" when "1110", --e
"0111000" when others; --f
end arch;