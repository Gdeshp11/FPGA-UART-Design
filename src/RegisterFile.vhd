library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity RegisterFile is
generic (
             DEPTH: integer := 6;
             DBITS: integer := 8
); --Fifo Depth is 32 bytes of data
port(
 clk,reset : in std_logic;
 din : in std_logic_vector(DBITS-1 downto 0);
 w_addr,r_addr : in std_logic_vector((DEPTH - 1) downto 0);
 w_en,r_en : in std_logic;
 dout : out std_logic_vector(DBITS-1 downto 0));
end RegisterFile;
architecture Behavioral of RegisterFile is
type registers is array ( 0 to (2 ** DEPTH)-1) of std_logic_vector (DBITS-1 downto 0); --
signal register_addr : registers; 
begin
process(clk,reset)
 begin
 if(reset = '1') then
 register_addr <= (others => (others => '0'));
 elsif(rising_edge(clk))then
 if (w_en = '1') then
 register_addr(to_integer(unsigned(w_addr))) <= din; 
 end if; 
 end if;
 end process; 
 dout <= register_addr(to_integer(unsigned(r_addr))) when r_en = '1' else
 (others => '0');
end Behavioral;


