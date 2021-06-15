library IEEE;
use IEEE.std_logic_1164.all;
entity ENCODER_TEST is
end ENCODER_TEST;
architecture ENCODER_TEST of ENCODER_TEST is
component ENCODER
port ( IN_10 : in std_logic_vector(9 downto 0);
OUT_BCD : out std_logic_vector(3 downto 0) );
end component;
signal IN_10 : std_logic_vector(9 downto 0);
signal OUT_BCD : std_logic_vector(3 downto 0);
begin
U0:ENCODER port map ( IN_10 => IN_10, OUT_BCD => OUT_BCD );
process
begin
IN_10 <= "1000100000";
for T in 0 to 15 loop
wait for 100 ns;
if (T = 0) then
IN_10 <= "0001000000";
elsif (T = 14) then
IN_10 <= (others => '0');
else IN_10 <= IN_10(8 downto 0) & IN_10(9);
end if;
end loop;
wait;
end process;
end ENCODER_TEST;