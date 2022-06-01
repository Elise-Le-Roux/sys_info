----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2022 17:27:10
-- Design Name: 
-- Module Name: Test_Banc_de_registres - Behavioral
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

entity Test_Banc_de_registres is
--  Port ( );
end Test_Banc_de_registres;

architecture Behavioral of Test_Banc_de_registres is

COMPONENT Banc_de_registres
PORT ( 
    Addr_A : in STD_LOGIC_VECTOR (3 downto 0);
    Addr_B : in STD_LOGIC_VECTOR (3 downto 0);
    Addr_W : in STD_LOGIC_VECTOR (3 downto 0);
    W : in STD_LOGIC;
    DATA : in STD_LOGIC_VECTOR (7 downto 0);
    RST : in STD_LOGIC;
    CLK : in STD_LOGIC;
    QA : out STD_LOGIC_VECTOR (7 downto 0);
    QB : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;

--Inputs
signal monAddr_A : STD_LOGIC_VECTOR (3 downto 0);
signal monAddr_B : STD_LOGIC_VECTOR (3 downto 0);
signal monAddr_W : STD_LOGIC_VECTOR (3 downto 0);
signal monW : STD_LOGIC;
signal monDATA : STD_LOGIC_VECTOR (7 downto 0);
signal monRST : STD_LOGIC := '1';
signal monCLK : STD_LOGIC := '0';

--Outputs
signal monQA : STD_LOGIC_VECTOR (7 downto 0);
signal monQB : STD_LOGIC_VECTOR (7 downto 0);

-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 1 ns;

begin

 -- Instantiate the Unit Under Test (UUT)
    Label_uut: Banc_de_registres PORT MAP (
        Addr_A => monAddr_A,
        Addr_B => monAddr_B,
        Addr_W => monAddr_W,
        W => monW,
        DATA => monDATA,
        RST => monRST,
        CLK => monCLK,
        QA => monQA,
        QB => monQB
    );
    
    -- Clock process definitions
    Clock_process : process
    begin
        monCLK <= not(monCLK);
    wait for Clock_period/2;
    end process;
    
    -- Stimulus process
    monDATA <= X"A2" after 5 ns;
    monAddr_W <= X"5" after 5 ns;
    monW <= '1' after 6 ns, '0' after 9 ns;
    monAddr_A <= X"5" after 10 ns;
    monAddr_B <= X"7" after 10 ns;
    monRST <= '0' after 15 ns;
end Behavioral;
