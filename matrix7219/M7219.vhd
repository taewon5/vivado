library ieee;
use ieee.std_logic_1164.all;
entity M7219 is
 port (
 clk : in std_logic;
  -- parallel : in std_logic_vector(31 downto 0); 
 clk_out : out std_logic;
 data_out : out std_logic;
 load : out std_logic
 );
end entity;
architecture rtl of M7219 is
attribute syn_encoding : string;
type state_machine is (init_1, init_2, init_3, init_4, read_data, dig_7, dig_6, dig_5, dig_4, dig_3,
dig_2, dig_1, dig_0,NOOP1,NOOP2,NOOP3,NOOP4,NOOP5,NOOP6,NOOP7,NOOP8,NOOP9,NOOP10,NOOP11,NOOP12,
dig_8,dig_9,dig_10,dig_11,dig_12,dig_13,dig_14,dig_15,dig_16,dig_17,dig_18,dig_19,dig_20,dig_21,
dig_22,dig_23,dig_24,dig_25,dig_26,dig_27,dig_28,dig_29,dig_30);
attribute syn_encoding of state_machine : type is "safe";
signal state : state_machine := init_1;
type driver_machine is (idle, start,save, clk_data, clk_high, clk_low, finished);
attribute syn_encoding of driver_machine : type is "safe";
signal driver_state : driver_machine := save;
------------------------------------------------------------------------------------------------------------------------------
--- The keyword "safe" indicates that the VIVADO software should insert extra logic --- to detect an illegal state (an unreachable state) and force the state machine into the reset --- state. ------------------------------------------------------------------------------------------------------------------------------
signal command : std_logic_vector(15 downto 0) := x"0000";
signal driver_start : std_logic := '0';
-- function hex2seg(num : std_logic_vector(3 downto 0)) return std_logic_vector is
-- begin
-- case num is -- when "0000" => return("01111110"); -- 0
-- when "0001" => return("00110000"); -- 1
-- when "0010" => return("01101101"); -- 2
-- when "0011" => return("01111001"); -- 3
-- when "0100" => return("00110011"); -- 4
-- when "0101" => return("01011011"); -- 5
-- when "0110" => return("01011111"); -- 6
-- when "0111" => return("01110000"); -- 7
-- when "1000" => return("01111111"); -- 8
-- when "1001" => return("01111011"); -- 9
-- when "1010" => return("01110111"); -- A
-- when "1011" => return("00011111"); -- b
-- when "1100" => return("00001101"); -- c
-- when "1101" => return("00111101"); -- d
-- when "1110" => return("01001111"); -- E
-- when "1111" => return("01000111"); -- F
-- when others => return("00000000"); -- end case; -- end hex2seg;
begin
 process
 variable counter : integer := 0; variable clk_counter : integer := 0; 
 -- variable latch_in : std_logic_vector(63 downto 0) := x"FFFEFCF8 F0E0C080";
  variable dig0_data1 : std_logic_vector(7 downto 0) := x"00";
  variable dig1_data1 : std_logic_vector(7 downto 0) := x"40";
  variable dig2_data1 : std_logic_vector(7 downto 0) := x"40";
  variable dig3_data1 : std_logic_vector(7 downto 0) := x"40";
  variable dig4_data1 : std_logic_vector(7 downto 0) := x"40";
  variable dig5_data1 : std_logic_vector(7 downto 0) := x"40";
  variable dig6_data1 : std_logic_vector(7 downto 0) := x"7E";
  variable dig7_data1 : std_logic_vector(7 downto 0) := x"00";
  variable dig0_data2 : std_logic_vector(7 downto 0) := x"00";
  variable dig1_data2 : std_logic_vector(7 downto 0) := x"3c";
  variable dig2_data2 : std_logic_vector(7 downto 0) := x"42";
  variable dig3_data2 : std_logic_vector(7 downto 0) := x"42";
  variable dig4_data2 : std_logic_vector(7 downto 0) := x"42";
  variable dig5_data2 : std_logic_vector(7 downto 0) := x"42";
  variable dig6_data2 : std_logic_vector(7 downto 0) := x"3c";
  variable dig7_data2 : std_logic_vector(7 downto 0) := x"00";
  variable dig0_data3 : std_logic_vector(7 downto 0) := x"00";
  variable dig1_data3 : std_logic_vector(7 downto 0) := x"42";
  variable dig2_data3 : std_logic_vector(7 downto 0) := x"42";
  variable dig3_data3 : std_logic_vector(7 downto 0) := x"42";
  variable dig4_data3 : std_logic_vector(7 downto 0) := x"42";
  variable dig5_data3 : std_logic_vector(7 downto 0) := x"24";
  variable dig6_data3 : std_logic_vector(7 downto 0) := x"18";
  variable dig7_data3 : std_logic_vector(7 downto 0) := x"00";
  variable dig0_data4 : std_logic_vector(7 downto 0) := x"00";
  variable dig1_data4 : std_logic_vector(7 downto 0) := x"7e";
  variable dig2_data4 : std_logic_vector(7 downto 0) := x"40";
  variable dig3_data4 : std_logic_vector(7 downto 0) := x"7e";
  variable dig4_data4 : std_logic_vector(7 downto 0) := x"40";
  variable dig5_data4 : std_logic_vector(7 downto 0) := x"40";
  variable dig6_data4 : std_logic_vector(7 downto 0) := x"7E";
  variable dig7_data4 : std_logic_vector(7 downto 0) := x"00";
 begin
 wait until rising_edge(clk);
 ------------------------------------------------------------------------
 -- initialize and set display data
 ------------------------------------------------------------------------
 case state is
 when init_1 =>
 if (driver_state = save) then
 command <= x"0c01"; -- shutdown "or XCX1" / normal "XCX0"
 driver_state <= start;
 driver_state<=save;
 state <= init_2; 
 end if; 
 when init_2 =>
 if (driver_state = save) then
 command <= x"0900"; -- "X900" decode mode
 driver_state <= start; 
 driver_state<=save;
 state <= init_3; end if; when init_3 =>
 if (driver_state = save) then
 command <= x"0A00"; -- intensity
 driver_state <= start; 
  driver_state<=save;
 state <= init_4; end if; 
 when init_4 =>
 if (driver_state =save) then
 command <= x"0B07"; -- scan limit
 driver_state <= start;
 driver_state<=save;
 driver_state <=idle;
 state <= dig_7; 
 end if;
 when dig_7 =>
 if (driver_state =idle) then
 command <= x"08" & dig7_data1;
 driver_state <= start;
 state <= dig_6;
 end if;
 when dig_6 =>
 if (driver_state =idle) then
 command <= x"07" & dig6_data1;
 driver_state <=  start; 
 state <= dig_5;
 end if;
 when dig_5 =>
 if (driver_state =idle) then
 command <= x"06" & dig5_data1;
 driver_state <= start;
 state <= dig_4;
 end if;
 when dig_4 =>
 if (driver_state =idle) then
 command <= x"05"& dig4_data1;
 driver_state <= start;
 state <= dig_3;
 end if;
 when dig_3 =>
 if (driver_state = idle) then
 command <= x"04" & dig3_data1;
 driver_state <= start;
 state <= dig_2; 
 end if; when dig_2 =>
 if (driver_state =idle) then
 command <= x"03"& dig2_data1;
 driver_state <= start; 
 state <= dig_1; 
 end if; 
 when dig_1 =>
 if (driver_state = idle) then
 command <= x"02"& dig1_data1;
 driver_state <= start;
  state <= dig_0; 
 end if; 
 when dig_0 =>
 if (driver_state = idle) then
 command <= x"01" & dig0_data1;
 driver_state <= start;
 state <= NOOP1;
 end if;
 when NOOP1 =>
 if (driver_state = idle) then
 command <= x"0000";
 driver_state <= start;
 state <= NOOP2;
 end if;
 when NOOP2 =>
 if (driver_state =idle) then
 command <= x"0000";
 driver_state <= start;
 state <= NOOP3;
 end if;
 when NOOP3 =>
 if (driver_state = idle) then
 command <= x"0000";
 driver_state <= start;
 driver_state <= save;
 state <=read_data;
 end if;
--  when NOOP4 =>
-- if (driver_state = start) then
-- command <= x"0000";
-- driver_state <= start;
-- state <= dig_15;
-- end if;
-- when dig_15 =>
-- if (driver_state = idle) then
-- command <= x"08"& dig7_data2;
-- driver_state <= start;
--  state <= dig_14; 
-- end if; 
--  when dig_14 =>
-- if (driver_state = idle) then
-- command <= x"07"& dig6_data2;
-- driver_state <= start;
--  state <= dig_13; 
-- end if; 
--  when dig_13 =>
-- if (driver_state = idle) then
-- command <= x"06"& dig5_data2;
-- driver_state <= start;
--  state <= dig_12; 
-- end if; 
--  when dig_12 =>
-- if (driver_state = idle) then
-- command <= x"05"& dig4_data2;
-- driver_state <= start;
--  state <= dig_11; 
-- end if; 
--  when dig_11 =>
-- if (driver_state = idle) then
-- command <= x"04"& dig3_data2;
-- driver_state <= start;
--  state <= dig_10; 
-- end if; 
--  when dig_10=>
-- if (driver_state = idle) then
-- command <= x"03"& dig2_data2;
-- driver_state <= start;
--  state <= dig_9; 
-- end if; 
--  when dig_9 =>
-- if (driver_state = idle) then
-- command <= x"02"& dig1_data2;
-- driver_state <= start;
--  state <= dig_8; 
-- end if; 
--  when dig_8 =>
-- if (driver_state = idle) then
-- command <= x"01"& dig0_data2;
-- driver_state <= start;
-- state <= NOOP5;
-- end if;
-- when NOOP5 =>
-- if (driver_state = idle) then
-- command <= x"0000";
-- driver_state <= start;
-- state <= NOOP6;
-- end if;
--  when NOOP6 =>
-- if (driver_state = idle) then
-- command <= x"0000";
-- driver_state <= start;
-- state <= read_data;  
-- end if; 
 when others => null;
 end case;
 -------------------------------------------------------------------------------
 -- fsm to send data
 -------------------------------------------------------------------------------
 if (clk_counter < 2000) then -- 12MHz -> 6KHz
 clk_counter := clk_counter + 1; else
 clk_counter := 0;
 case driver_state is
 when idle =>
 --load <= '1';
 clk_out <= '0'; 
 when save=>
 load<='1';
 --clk_out <= '0'; 
 when start =>
 load <= '0'; 
 counter := 16; 
 driver_state <= clk_data; 
 when clk_data =>
 counter := counter - 1;
 data_out <= command(counter); 
 driver_state <= clk_high; 
 when clk_high =>
 clk_out <= '1'; 
 driver_state <= clk_low; 
 when clk_low =>
 clk_out <= '0'; 
 if (counter = 0) then
 --load <= '1';
 driver_state <= finished;
  else driver_state <= clk_data;
   end if;
    when finished =>
 driver_state <= idle;
  when others => null;
   end case; 
   end if;-- clk_counter
 end process;
end architecture;