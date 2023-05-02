library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BaudGenSim is
--  Port ( );
end BaudGenSim;

architecture Behavioral of BaudGenSim is

signal clk,reset,s_tick : std_logic;
constant T : time := 20 ns;
begin
p0: entity work.BaudGenerator(Behavioral) port map(clk => clk, reset => reset, s_tick => s_tick); 
clck:process
 begin
clk <= '0';
wait for T/2;
clk <= '1';
wait for T/2;
end process;
sim : process
 begin
 reset <= '1';
wait for T;
reset <= '0';
wait;
end process;
end Behavioral;
