library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Uart_Tx is
--  Port ( );
port( 
      clk,rst,w_uart,r_uart       : in std_logic;
      tx_in                       : in std_logic_vector(7 downto 0);
      tx_out,txdone,full_tx,empty_tx          : out std_logic);
end Uart_Tx;

architecture Behavioral of Uart_Tx is
--signals

signal tx_start                            : std_logic;
signal txin_sig                            : std_logic_vector(7 downto 0);
signal txdonesig                           : std_logic;
--components
--Transmitter component
component UartTransmit
--  Port ( );
port(
     clk,reset,tx_start   : in std_logic;
     din                 : in std_logic_vector(7 downto 0);
     tx_done_tick,tx       : out std_logic);    
end component;
-- FIFO component
component FIFO is
--generic
generic (
DEPTH: integer := 6;
DBITS: integer := 8
);
port(
     clk,reset      : in std_logic;
     din  : in std_logic_vector(7 downto 0);
     write,read   : in std_logic;
     is_full,is_empty   : out std_logic;
     dout : out std_logic_vector(7 downto 0));
end component;

begin

tx_start      <= '1' when r_uart = '1' else
                  '0';

 Fifo_T : FIFO port map (clk => clk, reset => rst, din => tx_in, write => w_uart, read => r_uart, is_full => full_tx, 
                          is_empty => empty_tx, dout => txin_sig); 
 T       : UartTransmit port map (clk => clk, reset => rst, tx_start => tx_start, din => txin_sig, tx_done_tick => txdonesig, tx => tx_out);
  
--output logic
txdone <= txdonesig; 
end Behavioral;