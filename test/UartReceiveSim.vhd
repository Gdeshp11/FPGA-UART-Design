library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity UartReceiveSim is
--  Port ( );
end UartReceiveSim;

architecture Behavioral of UartReceiveSim is

--signal
signal clk,reset,rx,rx_done_tick : std_logic;
signal dout : std_logic_vector(7 downto 0);
--constant
constant T : time := 20 ns;
begin
--port map
UUT: entity work.UartReceiver(behavioral) port map(clk => clk, reset => reset, rx => rx, dout => 
dout, rx_done_tick => rx_done_tick);
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
wait for T*50;
reset <= '0';
wait;
 end process;
--data bits
data : process
 begin
 rx <= '0';
 wait for (27 * 16 * T);
 rx <= '1';
 wait for (27 * 16 * T);
 rx <= '0';
 wait for (27 * 16 * T);
 rx <= '1';
 wait for (27 * 16 * T);
 rx <= '0';
 wait for (27 * 16 * T);
 rx <= '1';
 wait for (27 * 16 * T);
 rx <= '0';
 wait for (27 * 16 * T);
 rx <= '1';
 wait for (27 * 16 * T);
 rx <= '1';
 wait for (27 * 16 * T);
 end process;
end Behavioral;
