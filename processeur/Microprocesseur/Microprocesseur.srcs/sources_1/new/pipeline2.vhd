----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 11:26:43
-- Design Name: 
-- Module Name: pipeline2 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline2 is
    Port ( inA : in STD_LOGIC_VECTOR (7 downto 0);
           inOP : in STD_LOGIC_VECTOR (7 downto 0);
           inB : in STD_LOGIC_VECTOR (7 downto 0);
           outA : out STD_LOGIC_VECTOR (7 downto 0);
           outOP : out STD_LOGIC_VECTOR (7 downto 0);
           outB : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC);
end pipeline2;

architecture Behavioral of pipeline2 is
begin
    process
    begin
        wait until CLK'event and CLK='1';
            outA <= inA;
            outOP <= inOP;
            outB <= inB;
    end process;
end Behavioral;

