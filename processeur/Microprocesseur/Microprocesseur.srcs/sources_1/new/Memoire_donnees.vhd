----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 09:38:21
-- Design Name: 
-- Module Name: Memoire_donnees - Behavioral
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

entity Memoire_donnees is
    Port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
           INPUT : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
end Memoire_donnees;

architecture Behavioral of Memoire_donnees is
    type Memoire_donnees is array (0 to 31) of STD_LOGIC_VECTOR(7 downto 0);
    signal Memory: Memoire_donnees ;
begin
    process
    begin
        wait until CLK'event and CLK='1';
            if (RST='0') then --RESET
                Memory<=(others => x"00");
            else
                if(RW='0') then --ECRITURE
                    Memory(to_integer(unsigned(Addr))) <= INPUT;
                -- else --LECTURE
                   -- OUTPUT <= Memory(to_integer(unsigned(Addr)));
                end if;
            end if;
                
--      wait until CLK'event and CLK='0';
--            if (RST='0') then --RESET
--                Memory<=(others => x"00");
--            else
--                if(RW='1') then --LECTURE
--                    OUTPUT <= Memory(to_integer(unsigned(Addr)));
--                end if;
--            end if;
                
    end process;
    OUTPUT <= Memory(to_integer(unsigned(Addr))); --LECTURE -- essayer avec lecture sur front descendant
end Behavioral;
