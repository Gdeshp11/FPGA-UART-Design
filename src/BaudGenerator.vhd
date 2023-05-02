library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity BaudGenerator is
generic(
          N: integer := 27  -- for baud rate of 115200 
          -- 115200*16 = 1843200   (50MHz/1843200)=27
        );  
port(
     clk,reset: in std_logic;
     s_tick: out std_logic);
end BaudGenerator;

architecture Behavioral of BaudGenerator is
signal r_reg,r_next : integer range 0 to N-1;
begin
    --process block
    process(clk,reset)
    begin
        if(reset = '1') then
            r_reg <= 0;
        elsif(clk'event and clk='1') then 
            r_reg <= r_next;
        end if;      
    end process;
--next state logic
    r_next <= 0 when r_reg = N else
                 r_reg + 1;
--output logic
    s_tick <= '1' when r_reg = N else
              '0';
end Behavioral;


