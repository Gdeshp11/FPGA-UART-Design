----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2023 10:46:19 PM
-- Design Name: 
-- Module Name: Transmitter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Transmitter is
  generic(
          n: Integer:=7
           );

  Port ( 
        s_tck: in std_logic;
        tx_start: in std_logic;
        data_buf:in std_logic_vector(n downto 0);
        tx_done_tick: out std_logic;
        tx:out std_logic 
        );
end Transmitter;

architecture Behavioral of Transmitter is
--Type Declaration
type state is (idle, start, stop, data);
--Signal Declarations
signal state_reg, state_next: state;
signal dummy: std_logic:='0';
signal dum: std_logic_vector(7 downto 0);

begin

process(s_tck)
   begin
   
    if tx_start = '0' then          --Active Low
        state_reg <= idle;
    elsif rising_edge(s_tck) then
        state_reg <= state_next;
    end if;
    
end process;


process(state_reg)
--Constants
variable count: Integer:=n;
begin
    case state_reg is
    
        when idle => 
                state_next <= start;
        when start => 
                if tx_start = '1' then
                tx <= '0';
                state_next <= data;
                end if;
        when stop => 
                tx_done_tick <= '1';
                tx <= '1';
                state_next <= idle;
        when data => 
                dummy <= not(dummy);
                count := count - 1;
                if count = 0 then
                    state_next <= stop;
                end if;
        when others => 
                state_next <= idle;
        
    end case;
end process;

process(dummy)
begin
if rising_edge(dummy) then
    tx <= data_buf(0);
    dum <= '0' & data_buf(n downto 1);
end if;
end process;


end Behavioral;
