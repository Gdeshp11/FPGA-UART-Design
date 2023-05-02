library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity classenginesim is
generic(
         W : integer:= 8 );
end classenginesim;
architecture Behavioral of classenginesim is
signal clk,reset : std_logic;
signal din,dout :  std_logic_vector(W-1 downto 0);
constant T : time := 100 ns;
begin
p0: entity work.classengine(Behavioral) port map(clk => clk, reset => reset, din => din, dout => dout);

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

datain: process
begin
din <= "01000010";
wait for 100ns;
end process;
end Behavioral;