library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity UartTransmitSim is
generic(
DBIT: integer := 8);
--  Port ( );
end UartTransmitSim;

architecture Behavioral of UartTransmitSim is
--signal
signal clk,reset,tx,tx_start,tx_done_tick : std_logic;
signal din : std_logic_vector(DBIT-1 downto 0);
--constant
constant T : time := 20 ns;
begin
Unit1: entity work.UartTransmit(behavioral) port map(clk => clk, reset => reset, tx => tx, tx_start => tx_start, din 
=> din, tx_done_tick => tx_done_tick);
--clock
clock:process
 begin
 clk <= '0';
wait for T/2;
clk <= '1';
wait for T/2;
 end process;
--reset
rst : process
 begin
 reset <= '1';
wait for T;
reset <= '0';
tx_start <= '1';
wait;
 end process;
data : process
 begin
 din <= x"7A";
 wait for (10 * 27 * 16 * T);
 din <= x"80";
 wait for (10 * 27 * 16 * T);
 end process;

end Behavioral;
