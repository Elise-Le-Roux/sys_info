----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 10:19:52
-- Design Name: 
-- Module Name: Test_Memoire_donnees - Behavioral
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

entity Test_Memoire_donnees is
--  Port ( );
end Test_Memoire_donnees;

architecture Behavioral of Test_Memoire_donnees is

COMPONENT Memoire_donnees
PORT(
    Addr : in STD_LOGIC_VECTOR (7 downto 0);
    INPUT : in STD_LOGIC_VECTOR (7 downto 0);
    RW : in STD_LOGIC;
    RST : in STD_LOGIC;
    CLK : in STD_LOGIC;
    OUTPUT : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;

--Inputs
signal monAddr : STD_LOGIC_VECTOR (7 downto 0);
signal monINPUT : STD_LOGIC_VECTOR (7 downto 0);
signal monRW : STD_LOGIC;
signal monRST : STD_LOGIC := '1';
signal monCLK : STD_LOGIC := '0';

--Outputs
signal monOUTPUT : STD_LOGIC_VECTOR (7 downto 0);

-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 1 ns;

begin
 -- Instantiate the Unit Under Test (UUT)
   Label_uut: Memoire_donnees PORT MAP (
       Addr => monAddr,
       INPUT => monINPUT,
       RW => monRW,
       RST => monRST,
       CLK => monCLK,
       OUTPUT => monOUTPUT
   );
   
   -- Clock process definitions
   Clock_process : process
   begin
       monCLK <= not(monCLK);
   wait for Clock_period/2;
   end process;
   
   -- Stimulus process
   monRW <= '0' after 2 ns, '1' after 5 ns, '0' after 7 ns, '1' after 10 ns;
   monINPUT <=  X"05" after 1 ns, x"03" after 7 ns;
   monAddr <= X"01" after 1 ns, x"00" after 9 ns;
   --monRST <= '0' after 12 ns, '1' after 15 ns;
end Behavioral;
