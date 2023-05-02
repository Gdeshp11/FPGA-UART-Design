library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIFO is
    generic(
        WIDTH : integer := 8  -- generic width of FIFO
    );
    
    port(
        clk    : in std_logic;                       -- clock signal
        wr     : in std_logic;                       -- write signal
        rd     : in std_logic;                       -- read signal
        w_data : in std_logic_vector(WIDTH-1 downto 0); -- data to be written
        empty  : out std_logic;                      -- empty flag (output)
        full   : out std_logic;                      -- full flag (output)
        r_data : out std_logic_vector(WIDTH-1 downto 0) -- data to be read (output)
    );
end FIFO;

architecture Behavior of FIFO is
    type register_file is array (0 to 7) of std_logic_vector((WIDTH-1) downto 0); -- array of registers
    signal regs : register_file;                                                 -- signal of registers
    
    signal wp : std_logic_vector(3 downto 0) := "0000";   -- write pointer signal
    signal rp : std_logic_vector(3 downto 0) := "0000";   -- read pointer signal
begin
    process (clk) is   -- synchronous process triggered on clock edge
    begin
        if rising_edge(clk) then  -- check for rising edge of clock
            if wp = rp then      -- check if FIFO is empty
                if wp(3) = '1' then  -- wrap-around to beginning of array
                    wp(3) <= '0';  
                end if;
                
                empty <= '1';    -- set empty flag
            end if;
        
            -- Write
            if wr = '1' then
                if wp(3) = '0' then
                    regs(to_integer(unsigned(wp))) <= w_data;  -- write data to register
                end if;
                
                wp <= std_logic_vector(to_unsigned(to_integer(unsigned(wp)) + 1, 4));  -- increment write pointer
                empty <= '0';   -- clear empty flag
            end if;
            
            -- Read
            if rd = '1' then
                r_data <= regs(to_integer(unsigned(rp(2 downto 0))));  -- read data from register
                rp <= std_logic_vector(to_unsigned(to_integer(unsigned(rp)) + 1, 4));  -- increment read pointer
            end if;
            
            -- Set empty/full bits
            full <= wp(3);    -- set full flag
        end if;
    end process;
end Behavior;
