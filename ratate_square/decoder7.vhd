library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
entity decoder7 is
port(
clk: in std_logic;
X : in STD_LOGIC_VECTOR(1 downto 0);
F: out STD_LOGIC_VECTOR(6 downto 0);
AN: out STD_LOGIC_VECTOR(3 downto 0) );
end decoder7;
architecture behavioral of decoder7 is
constant N: integer :=24; -- 2^^15=32768
constant M: integer :=8; -- 2^^15=32768
signal q_reg, q_next: unsigned(N-1 downto 0);
signal r_reg, r_next: unsigned(M-1 downto 0);
signal sel: std_logic_vector(2 downto 0);
signal sel2: std_logic_vector(1 downto 0);
signal hex: std_logic_vector(1 downto 0);
signal hex2: std_logic_vector(2 downto 0);
-- 12MHz/(2^15)=366.21Hz ; 2^^15=32768
begin
-- register
process(clk)
begin
if(clk'event and clk='1') then
q_reg <= q_next;
r_reg <= r_next;
end if;
end process;

-- next-state logic for the counter
r_next <= r_reg + 1;
q_next <= q_reg + 1;
-- 2 MSBs of counter to control 4X1 multiplex and 2x4 Decoder
sel <= std_logic_vector(q_reg(N-1 downto N-3));
sel2 <= std_logic_vector(r_reg(M-1 downto M-2));

process(sel,hex2,sel2,X) -- 2x4 Decoder & 4x1 Mux
begin
case sel is
when "000" =>
hex2 <= "000";
when "001" =>
hex2 <= "001";
when "010" =>
hex2 <= "010";
when "011" =>
hex2 <= "011";
when "100" =>
hex2 <= "100";
when "101" =>
hex2 <= "101";
when others=>
hex2 <="110";
end case;
if hex2="000" then
case sel2 is
when "00" =>
AN<="0100"; HEX<=X;
when "01" =>
AN<="0010"; HEX<=X+1;
when "10" =>
AN<="0100"; HEX<=X+2;
when others =>
AN<="0010"; HEX<=X+3;
end case;
elsif hex2="001" then
case sel2 is
when "00" =>
AN<="0010"; HEX<=X;
when "01" =>
AN<="0100"; HEX<=X+1;
when "10" =>
AN<="0010"; HEX<=X+2;
when others =>
AN<="0100"; HEX<=X+3;
end case;
elsif hex2="010" then
case sel2 is
when "00" =>
AN<="1000"; HEX<=X;
when "01" =>
AN<="0001"; HEX<=X+1;
when "10" =>
AN<="1000"; HEX<=X+2;
when others =>
AN<="0001"; HEX<=X+3;
end case;
elsif hex2="011" then
case sel2 is
when "00" =>
AN<="0001"; HEX<=X;
when "01" =>
AN<="1000"; HEX<=X+1;
when "10" =>
AN<="0001"; HEX<=X+2;
when others =>
AN<="1000"; HEX<=X+3;
end case;
elsif hex2="100" then
case sel2 is
when "00" =>
AN<="1000"; HEX<=X;
when "01" =>
AN<="0001"; HEX<=X+1;
when "10" =>
AN<="1000"; HEX<=X+2;
when others =>
AN<="0001"; HEX<=X+3;
end case;
elsif hex2="101" then
case sel2 is
when "00" =>
AN<="0010"; HEX<=X;
when "01" =>
AN<="0100"; HEX<=X+1;
when "10" =>
AN<="0010"; HEX<=X+2;
when others =>
AN<="0100"; HEX<=X+3;
end case;
else
case sel2 is
when "00" =>
AN<="0100"; HEX<=X;
when "01" =>
AN<="0010"; HEX<=X+1;
when "10" =>
AN<="0100"; HEX<=X+2;
when others =>
AN<="0010"; HEX<=X+3;
end case;
end if;
end process;
-- Common Anode type ------------------------------
with hex select
F(6 downto 0) <=
"1001111" when "00",
"1111001" when "01",
"1001111" when "10",
"1111001"  when others;
end Behavioral;