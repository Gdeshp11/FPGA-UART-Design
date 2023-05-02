library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity UartTransmit is
generic(
DBIT: integer := 8;
SB_TICK: integer := 16
);
 Port (
        clk,reset,tx_start : in std_logic;
        din: in std_logic_vector(DBIT-1 downto 0);
        tx_done_tick, tx: out std_logic
  );
end UartTransmit;

architecture Behavioral of UartTransmit is
type state_type is (idle, start, data, stop);
signal state_reg, state_next: state_type;
signal s_reg, s_next : integer range 0 to SB_TICK-1; -- ticks = 16
signal n_reg, n_next : integer range 0 to DBIT-1; -- data bits count = 8
signal b_reg, b_next: std_logic_vector(7 downto 0);
signal tx_reg, tx_next: std_logic;
signal s_tick : std_logic; 

component BaudGenerator is
-- Port ( );
port(
 clk,reset: in std_logic;
 s_tick: out std_logic);
end component;
begin
Baudrate: BaudGenerator port map (clk => clk, reset => reset, s_tick => s_tick);
--process FSMD state and data registers
 process(clk,reset)
 begin
 if(reset = '1') then
 state_reg <= idle;
 s_reg <= 0;
 n_reg <= 0;
 b_reg <= (others => '0');
 tx_reg <= '1';
 elsif(rising_edge(clk)) then
 state_reg <= state_next;
 s_reg <= s_next;
 n_reg <= n_next;
 b_reg <= b_next;
 tx_reg <= tx_next;
 
 end if;
 end process;
 
 --next state logic
process (state_reg, s_reg, n_reg, b_reg, s_tick, tx_reg, tx_start, din)
 begin
 state_next <= state_reg;
 s_next <= s_reg;
 n_next <= n_reg;
 b_next <= b_reg;
 tx_next<= tx_reg; 
 tx_done_tick <= '0';
 
 case state_reg is
 -- idle state
 when idle =>
 tx_next <= '1'; 
 if(tx_start = '1') then
 state_next <= start;
 s_next <= 0;
 b_next <= din;
 else
 state_next <= idle;
 end if;
 --start state
 when start =>
 tx_next <= '0'; 
 if(s_tick = '0') then
 state_next <= start;
 else
 if(s_reg = (SB_TICK-1)) then --slowing down the baud tick
 state_next <= data;
 s_next <= 0;
 n_next <= 0;
 else
 state_next <= start;
 s_next <= s_reg + 1;
 end if;
 end if;
 
 -- data state
 when data =>
 tx_next <= b_reg(0);
 
 if(s_tick = '0') then
 state_next <= data;
 else
 if(s_reg = (SB_TICK-1)) then
 s_next <= 0;
 b_next <= '0' & b_reg(7 downto 1);
 if(n_reg =(DBIT - 1) ) then 
 state_next <= stop;
 n_next <= 0;
 else
 state_next <= data;
 n_next <= n_reg + 1;
 end if;
 else
 s_next <= s_reg + 1;
 end if;
 end if;
 
-- stop state
 when stop =>
 tx_next <= '1'; 
 if(s_tick = '0') then
 state_next <= stop;
 else
 if(s_reg = (SB_TICK-1)) then 
 state_next <= idle;
 tx_done_tick <= '1';  -- Tx done bit
 s_next <= 0; 
 else
 state_next <= stop;
 s_next <= s_reg + 1;
 end if;
 end if;
end case;
end process;
 
 -- output logic
 tx <= tx_reg; 
end Behavioral;
