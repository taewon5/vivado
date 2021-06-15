LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL
;
ENTITY Decoder_3x8_tb IS
END Decoder_3x8_tb;
ARCHITECTURE behavior OF Decoder_3x8_tb IS 
COMPONENT Decoder_3x8_2
PORT( IN_BCD : IN std_logic_vector(2 downto 0);
OUT_OCT : OUT std_logic_vector(7 downto 0) );
END COMPONENT; 
signal IN_BCD : std_logic_vector(2 downto 0) := (others => '0');
signal OUT_OCT : std_logic_vector(7 downto 0);
BEGIN
uut: Decoder_3x8_2 PORT MAP (
IN_BCD => IN_BCD,
OUT_OCT => OUT_OCT );
stim_proc: process
begin
IN_BCD <= (others => '0');
for T in 0 to 8 loop
wait for 100 ns; IN_BCD <= IN_BCD + '1';
end loop;
wait;
end process;
END;