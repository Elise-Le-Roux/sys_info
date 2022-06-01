----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2022 15:24:57
-- Design Name: 
-- Module Name: Banc_de_registres - Behavioral
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

entity Banc_de_registres is
    Port ( Addr_A : in STD_LOGIC_VECTOR (3 downto 0);
           Addr_B : in STD_LOGIC_VECTOR (3 downto 0);
           Addr_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_de_registres;

architecture Behavioral of Banc_de_registres is
    type Banc_registres is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
    signal BR: Banc_registres ;
begin
    QA <= BR(to_integer(unsigned(addr_A))) when W = '0' or addr_W /= addr_A else DATA;
    QB <= BR(to_integer(unsigned(addr_B))) when W = '0' or addr_W /= addr_B else DATA;
    process
    begin
        wait until CLK'event and CLK='1';
                if(RST='0') then 
                    BR<=(others => (others => '0'));
                elsif (W = '1') then
                        BR(to_integer(unsigned(addr_W)))<= DATA;
                end if;            
    end process;

end Behavioral;
