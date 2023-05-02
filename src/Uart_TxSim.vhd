----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/29/2022 03:20:14 PM
-- Design Name: 
-- Module Name: Uart_TxSim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Uart_TxSim is
--  Port ( );
end Uart_TxSim;

architecture Behavioral of Uart_TxSim is
signal clk, rst, tx_out, w_uart, r_uart : std_logic;
signal tx_in                            : std_logic_vector(7 downto 0);
--constant
constant T : time := 200 ns;
begin
--port map
UUT: entity work.Uart_Tx(behavioral) port map(clk => clk, rst => rst, tx_in => tx_in, w_uart => w_uart, r_uart => r_uart , tx_out => tx_out);
--clock
clock:process
  begin
    clk <= '1';
	wait for T/2;
	clk <= '0';
	wait for T/2;
  end process;
--reset
reset : process
  begin
    rst <= '1';
	wait for T;
	rst <= '0';
	wait;
  end process;
-- write enable
 wr : process
     begin
         wait for T;
         w_uart <= '1';
         wait for 33 * T;
         w_uart <= '0';
         wait;
     end process;
     
 -- read_enable
 rd: process
    begin
        wait for (34 * T);
        r_uart <= '1';
        wait;
    end process;
    
--data bits
data  : process
  begin
      wait for T;
      wait until falling_edge(clk);
      tx_in <= x"01";
      for i in 0 to 31 loop
          wait for T;
          tx_in <= std_logic_vector(unsigned(tx_in) + 1);
      end loop;    
  end process;
end Behavioral;