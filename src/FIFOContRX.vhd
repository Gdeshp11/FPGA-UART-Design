library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity FIFOContRX is
generic (
           DEPTH: integer := 6
); --Fifo Depth is 64 bytes of data

port(
 clk,reset,read,write : in std_logic;
 is_full,is_empty : out std_logic;
 w_addr,r_addr : out std_logic_vector((DEPTH - 1) downto 0)
 ); 

end FIFOContRX;

architecture Behavioral of FIFOContRX is
signal r_addr_reg, r_addr_next : unsigned (DEPTH downto 0); -- 0 to 64 
signal w_addr_reg, w_addr_next : unsigned (DEPTH downto 0); -- 0 to 64 
signal is_full_flag, is_empty_flag : std_logic;
begin
process(clk, reset)
 begin
 if(reset = '1') then
 w_addr_reg <= (others =>'0');
 r_addr_reg <= (others =>'0');
 elsif(rising_edge(clk)) then 
 w_addr_reg <= w_addr_next;
 r_addr_reg <= r_addr_next;
 end if;
 end process;
 
 -- write address next state logic 
 w_addr_next <= w_addr_reg + 1 when (write = '1' and is_full_flag = '0') else
 w_addr_reg;
 
 -- full flag logic
 is_full_flag <= '1' when (r_addr_reg(DEPTH) /= w_addr_reg(DEPTH)) and (r_addr_reg(DEPTH-1 downto 0) = w_addr_reg(DEPTH-1 downto 0))
  else
 '0';
 
 -- write output logic
 w_addr <= std_logic_vector(w_addr_reg(DEPTH - 1 downto 0));
 
 -- full flag output
 is_full <= is_full_flag;

 -- read address next state logic
 r_addr_next <= r_addr_reg + 1 when (read = '1' and is_empty_flag = '0') 
 else
 r_addr_reg;

 -- empty flag logic 
 is_empty_flag <= '1' when (r_addr_reg = w_addr_reg) 
 else
 '0';
 
 -- read port output
 r_addr <= std_logic_vector(r_addr_reg(DEPTH - 1 downto 0));
 
 -- empty flag output
 is_empty <= is_empty_flag;
 
end Behavioral;

