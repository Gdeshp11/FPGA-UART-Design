library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity classengine is
generic(
         W : integer:= 8 );
  Port (
          clk, reset : in std_logic;
          din : in std_logic_vector(W-1 downto 0);
          dout : out std_logic_vector(w-1 downto 0)
  );
end classengine;
architecture Behavioral of classengine is
signal s_reg, s_next: std_logic_vector(W-1 downto 0);
begin
process(clk,reset)
begin
if (reset='1') then
s_reg <= (others => '0');
end if;
if (clk'event and clk = '1') then
  s_reg <= s_next;
end if;  
end process;
-- next state
process(din)
begin
if (din >= "00110000" and din <= "00111001") then  -- 0 to 9
  s_next <= "00000001";
elsif((din >= x"41" and din <= x"5a") or ( din>= x"61" and din <= x"7a")) then -- A to Z and a to z
  s_next <= "00000010";  
elsif( din = x"25" or din = x"2a" or din = x"2b" or din = x"2d" or din = x"2f") then -- %,*,+, -, /
  s_next <= "00000011";
else
  s_next <= "00000100";
end if;
end process;
-- output logic    
dout <= s_reg;
end Behavioral;