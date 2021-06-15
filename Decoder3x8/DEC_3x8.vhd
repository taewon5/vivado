library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEC_3x8 is port 
(
B2, B1, B0 : in std_logic;
F0, F1, F2, F3, F4, F5, F6, F7 : out std_logic );
end DEC_3x8
;
architecture DEC_3x8 of DEC_3x8 is
begin
F0 <= not B2 and not B1 and not B0;
F1 <= not B2 and not B1 and B0;
F2 <= not B2 and B1 and not B0;
F3 <= not B2 and B1 and B0;
F4 <= B2 and not B1 and not B0;
F5 <= B2 and not B1 and B0;
F6 <= B2 and B1 and not B0;
F7 <= B2 and B1 and B0;
end DEC_3x8;