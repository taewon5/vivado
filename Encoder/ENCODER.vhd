library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
entity ENCODER is
port ( IN_10 : in std_logic_vector( 9 downto 0 );
OUT_BCD : out std_logic_vector( 3 downto 0 ) );
end ENCODER;
architecture ENCODER of ENCODER is
begin
process( IN_10 )
variable BCD : std_logic_vector( 3 downto 0 );
begin
BCD := ( others => '0' ); -- Variable assignment :=
for T in 0 to 9 loop
if ( IN_10(T) = '1' ) then
BCD := BCD or conv_std_logic_vector( T, 4 );
end if;
end loop;
OUT_BCD <= BCD;
end process;
end ENCODER;