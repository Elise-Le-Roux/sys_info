----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 11:40:32
-- Design Name: 
-- Module Name: Test_Processeur - Behavioral
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

entity Test_Processeur is
--  Port ( );
end Test_Processeur;

architecture Behavioral of Test_Processeur is


COMPONENT Processeur 
PORT ( 
    OUTA : out STD_LOGIC_VECTOR (7 downto 0);
    OUTB : out STD_LOGIC_VECTOR (7 downto 0);
    RST : in STD_LOGIC;
    CK : in STD_LOGIC;
    N : out STD_LOGIC;
    O : out STD_LOGIC;
    Z : out STD_LOGIC;
    C : out STD_LOGIC;
    OUT1 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT2 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT3 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT4 : out STD_LOGIC_VECTOR (7 downto 0);
    OUTS : out STD_LOGIC_VECTOR (7 downto 0);
    OUT5 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT6 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT7 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT8 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT9 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT10 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT11 : out STD_LOGIC_VECTOR (7 downto 0);
    OUTINS : out STD_LOGIC_VECTOR (31 downto 0);
    OUT_ADDR_W : out STD_LOGIC_VECTOR (7 downto 0);
    OUT_OP4 : out STD_LOGIC_VECTOR (7 downto 0);
    OUT_DATA : out STD_LOGIC_VECTOR (7 downto 0);
    OUT_LC : out STD_LOGIC;
    OUT_RW : out STD_LOGIC;
    OUT_IP : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;

--Inputs
signal monRST : STD_LOGIC := '0';
signal monCLK : STD_LOGIC := '0';

--Outputs
signal monOUTA : STD_LOGIC_VECTOR (7 downto 0);
signal monOUTB : STD_LOGIC_VECTOR (7 downto 0);
signal monN : STD_LOGIC;
signal monO : STD_LOGIC;
signal monZ : STD_LOGIC;
signal monC : STD_LOGIC;
signal monOP1 : STD_LOGIC_VECTOR (7 downto 0);
signal monA1 : STD_LOGIC_VECTOR (7 downto 0);
signal monB1 : STD_LOGIC_VECTOR (7 downto 0);
signal monC1 : STD_LOGIC_VECTOR (7 downto 0);
signal monS : STD_LOGIC_VECTOR (7 downto 0);
signal monOP2 : STD_LOGIC_VECTOR (7 downto 0);
signal monA2 : STD_LOGIC_VECTOR (7 downto 0);
signal monB2 : STD_LOGIC_VECTOR (7 downto 0);
signal monC2 : STD_LOGIC_VECTOR (7 downto 0);
signal monOP3 : STD_LOGIC_VECTOR (7 downto 0);
signal monA3 : STD_LOGIC_VECTOR (7 downto 0);
signal monB3 : STD_LOGIC_VECTOR (7 downto 0);
signal monINS : STD_LOGIC_VECTOR (31 downto 0);
signal monADDR_W : STD_LOGIC_VECTOR (7 downto 0);
signal monOP4 : STD_LOGIC_VECTOR (7 downto 0);
signal monDATA : STD_LOGIC_VECTOR (7 downto 0);
signal monLC : STD_LOGIC;
signal monRW : STD_LOGIC;
signal monIP : STD_LOGIC_VECTOR (7 downto 0);

-- Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 40 ns;

begin
 -- Instantiate the Unit Under Test (UUT)
   Label_uut: Processeur PORT MAP (
       N => monN,
       O => monO,
       Z => monZ,
       C => monC,
       RST => monRST,
       CK => monCLK,
       OUTA => monOUTA,
       OUTB => monOUTB,
       OUT1 => monOP1,
       OUT2 => monA1,
       OUT3 => monB1,
       OUT4 => monC1,
       OUTS => monS,
       OUT5 => monOP2,
       OUT6 => monA2,
       OUT7 => monB2,
       OUT8 => monC2,
       OUT9 => monOP3,
       OUT10 => monA3,
       OUT11 => monB3,
       OUTINS => monINS,
       OUT_ADDR_W => monADDR_W,
       OUT_OP4 => monOP4,
       OUT_DATA => monDATA,
       OUT_LC => monLC,
       OUT_RW => monRW,
       OUT_IP => monIP
   );
   
       -- Clock process definitions
   Clock_process : process
   begin
       monCLK <= not(monCLK);
   wait for Clock_period/2;
   end process;
   
   -- Stimulus process
   monRST <= '1' after 200 ns;

end Behavioral;
