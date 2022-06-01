----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 10:15:26
-- Design Name: 
-- Module Name: Memoire_instructions - Behavioral
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

entity Memoire_instructions is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
end Memoire_instructions;

architecture Behavioral of Memoire_instructions is
    type Memoire_instructions is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
    signal Memory: Memoire_instructions ;
begin
    Memory <= (x"06010800", x"06020100", x"04040102", x"08020400", x"07010200", others => x"00000000"); 
    -- AFC R1 2
    -- AFC R2 1
    -- ADD R4 R1 R2
    -- STORE @2 R4
    -- LOAD R1 @2
    process
    begin
        wait until CLK'event and CLK='0'; -- front descendant
            OUTPUT <= Memory(to_integer(unsigned(Addr)));
    end process;
    --OUTPUT <= Memory(to_integer(unsigned(Addr)));
end Behavioral;
