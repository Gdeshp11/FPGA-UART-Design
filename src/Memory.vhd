library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity Memory is
port(
 addr: in std_logic_vector(6 downto 0); -- Address to write/read RAM
 di: in std_logic_vector(7 downto 0); -- Data to write into RAM
 read: in std_logic; -- Write enable 
 reset:in std_logic;
 en:in std_logic;
 clk: in std_logic; -- clock input for RAM
 do: out std_logic_vector(7 downto 0) -- Data output of RAM
);
end Memory;

architecture Behavioral of Memory is

type RAM_ARRAY is array (0 to 127 ) of std_logic_vector (7 downto 0);
signal RAM: RAM_ARRAY; 
begin
process(clk,reset) is
	begin
	   if Reset = '1' then
                -- Clear Memory on Reset
        RAM <= (others => (others => '0'));
	   end if;
 if(rising_edge(clk)) then
 if(read='1') then 
 RAM(to_integer(unsigned(addr))) <= di;
 end if;
 end if;

 if en='1' then
 do <= RAM(to_integer(unsigned(addr)));
 end if;
 end process;
end Behavioral;