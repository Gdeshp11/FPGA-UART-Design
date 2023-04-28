----------------------------------------------------------------------------------
-- Company: UNCC
-- Engineer: Gandhar Deshpande
-- 
-- Create Date: 04/27/2023 07:05:58 PM
-- Design Name: 
-- Module Name: baud_gen - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity baud_Gen is
    generic(
    N: integer := 4;
    M: integer := 10
    );
    
port(
clk, reset: in std_logic;
max_tick: out std_logic;
q: out std_logic_vector(N-1 downto 0)
);
end baud_Gen;

architecture arch of baud_Gen is
signal r_reg: unsigned(N-1 downto 0);
signal r_next: unsigned(N-1 downto 0);
begin
process(clk, reset)
begin
if (reset = '1') then
    r_reg <= (others => '0');
elsif (clk'event and clk='1') then
    r_reg <= r_next;
end if;
end process;

-- next state logic
r_next <= (others => '0') when r_reg=(M-1) else r_reg + 1;
-- output logic
q <= std_logic_vector(r_reg);
max_tick <= '1' when r_reg=(M-1) else '0';
end arch;
