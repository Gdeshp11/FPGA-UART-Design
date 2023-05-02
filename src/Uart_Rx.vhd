library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Uart_Rx is
--  Port ( );
port(
     clk,reset,rx_in,read: in std_logic;
     empty : out std_logic;
     rx_out : out std_logic_vector(7 downto 0));
end Uart_Rx;

architecture Behavioral of Uart_Rx is
--signals 
signal rx_done  : std_logic;
signal full  : std_logic;
signal dout_sig,txin_sig     : std_logic_vector(7 downto 0);
--components
--Receiver component
component UartReceiver
--  Port ( );
port(
     clk,reset,rx : in std_logic; 
     rx_done_tick     : out std_logic;
     dout      : out std_logic_vector(7 downto 0));
end component;


-- FIFO component
component FIFORX is
--generic
generic (DEPTH: integer :=6); --Fifo Depth is 32 bytes of data
--  Port ( );
port(
     clk,reset      : in std_logic;
     din  : in std_logic_vector(7 downto 0);
     write,read        : in std_logic;
     is_full,is_empty   : out std_logic;
     dout : out std_logic_vector(7 downto 0));
end component;
begin

R : UartReceiver port map(clk => clk, reset => reset, rx => rx_in,  rx_done_tick => rx_done,
                           dout => dout_sig); 
Fifo_R : FIFORX port map (clk => clk, reset => reset, din => dout_sig, write => rx_done, read => read,
                         is_full => full, is_empty => empty, dout => rx_out);
end Behavioral;