library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Uart_RxSim is
--  Port ( );
end Uart_RxSim;

architecture Behavioral of Uart_RxSim is
--signal
signal clk,reset,rx,read     : std_logic;
signal dout                    : std_logic_vector(7 downto 0);
--constant
constant T : time := 20 ns;
begin
--port map
UUT: entity work.Uart_Rx(behavioral) port map(clk => clk, reset => reset, rx_in => rx, read => read,
                                                    rx_out => dout);
--clock
clock:process
  begin
    clk <= '0';
	wait for T/2;
	clk <= '1';
	wait for T/2;
  end process;
--reset
rst : process
  begin
    reset <= '1';
	wait for T;
	reset <= '0';
	wait;
  end process;
  
-- read_enable
 rd: process
    begin
        wait for (2  * 156 * 27 * 16 * T);
        read <= '1';
        wait;
    end process;
    
--data bits
data  : process
    begin
      for i in 0 to 32 loop
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        wait for (27 * 8 * T);
        
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        wait for (27 * 8 * T);
        
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        rx <= '0';
        wait for (27 * 16 * T);
        rx <= '1';
        wait for (27 * 16 * T);
        wait for (27 * 8 * T);
     end loop;
    end process;
end Behavioral;
