LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
ENTITY Memorysim IS
END Memorysim;
ARCHITECTURE behavior OF Memorysim IS
COMPONENT Memory
    PORT(
         addr : IN  std_logic_vector(6 downto 0);
         di : IN  std_logic_vector(7 downto 0);
         read: IN  std_logic;
          reset: in std_logic;
          en:in std_logic;
         clk : IN  std_logic;
         do : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
 signal addr : std_logic_vector(6 downto 0) := (others => '0');
 signal di : std_logic_vector(7 downto 0) := (others => '0');
 signal read : std_logic := '0';
 signal reset : std_logic := '1';
 signal en : std_logic := '1';
 signal clk : std_logic := '0';
 signal do : std_logic_vector(7 downto 0);
 constant RAM_CLOCK_period : time := 10 ns;
 BEGIN
 uut: Memory PORT MAP (
          addr => addr,
          di => di,
          en=>en,
          read => read,
          clk => clk,
          reset =>reset,
          do => do
        );
   RAM_CLOCK_process :process
   begin
  clk <= '0';
  wait for RAM_CLOCK_period/2;
  clk <= '1';
  wait for RAM_CLOCK_period/2;
   end process;
   sim : process
 begin
 reset <= '1';
wait for RAM_CLOCK_period;
reset <= '0';
wait;
end process;

   stim_proc: process
   begin  
  read <= '0';
  addr <= "0000000";
  di <= x"FF";
      wait for 100 ns;
  for i in 0 to 5 loop
  addr <= addr + "0000001";
      wait for RAM_CLOCK_period*5;
  end loop;
  addr <= "0000000";
  read <= '1';
  wait for 100 ns;
  for i in 0 to 5 loop
  addr <= addr + "0000001";
  di <= di-x"01";
      wait for RAM_CLOCK_period*5;
  end loop;  
  read <= '0';
      wait;
   end process;
END;