LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
ENTITY bcd2ssd_test IS
END bcd2ssd_test;
ARCHITECTURE behavior OF bcd2ssd_test IS 
-- Component Declaration for the Unit Under Test (UUT)
COMPONENT bcd2ssd
PORT(
A,B,C,D : IN std_logic;
f : OUT std_logic_vector(6 downto 0);
digit : OUT std_logic
);
END COMPONENT;
signal IN_BCD : std_logic_vector(3 downto 0);
signal f : std_logic_vector(6 downto 0);
BEGIN
-- Instantiate the Unit Under Test (UUT)
uut: bcd2ssd PORT MAP (
A => IN_BCD(3), B=> IN_BCD(2), C => IN_BCD(1), D=>IN_BCD(0), f => f );
process
begin
IN_BCD <= (others => '0');
for T in 0 to 15 loop
wait for 100ns; IN_BCD <= IN_BCD + 1;
end loop;
wait;
end process;
END;
