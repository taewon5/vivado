library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity bcd2ssd is
Port ( A, B, C, D : in STD_LOGIC;
f : out STD_LOGIC_VECTOR (6 downto 0);
digit : out std_logic );
end bcd2ssd;
architecture dataflow of bcd2ssd is
begin
f(0) <= A or C or (B and D) or (not B and not D); -- f(a)
f(1) <= not B or (C and D) or (not C and not D); -- f(b)
f(2) <= not(not A and not b and c and not d); -- f(c)
f(3) <= A or (not B and C) or (not b and not D) or (C and not D) or (B and not C and D); -- f(d)
f(4) <= (not b and not d) or ( c and not d); -- f(e)
f(5) <= a or (b and not c) or (b and not d) or (not c and not d) ; -- f(f)
f(6) <= a or (b and not c) or ( not b and c) or (c and not d); -- f(g) 
digit <= '1';
end dataflow;

