----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2022 10:50:17
-- Design Name: 
-- Module Name: Test_ALU - Behavioral
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

entity Test_ALU is
--  Port ( );
end Test_ALU;

architecture Behavioral of Test_ALU is

COMPONENT ALU
PORT(
    A : in STD_LOGIC_VECTOR (7 downto 0);
    B : in STD_LOGIC_VECTOR (7 downto 0);
    N : out STD_LOGIC;
    O : out STD_LOGIC;
    Z : out STD_LOGIC;
    C : out STD_LOGIC;
    Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
    S : out STD_LOGIC_VECTOR (7 downto 0)
);
END COMPONENT;

--Inputs
signal monA : STD_LOGIC_VECTOR (7 downto 0) := X"01" ;
signal monB : STD_LOGIC_VECTOR (7 downto 0) := X"02";
signal monCtrl_Alu : STD_LOGIC_VECTOR (2 downto 0) := "001";

--Outputs
signal monN : STD_LOGIC := '0';
signal monO : STD_LOGIC := '0';
signal monZ : STD_LOGIC := '0';
signal monC : STD_LOGIC := '0';
signal monS : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

begin

    -- Instantiate the Unit Under Test (UUT)
    Label_uut: ALU PORT MAP (
        A => monA,
        B => monB,
        N => monN,
        O => monO,
        Z => monZ,
        C => monC,
        S => monS,
        Ctrl_Alu => monCtrl_Alu
    );
    
    -- Stimulus process
    monA <= X"01" after 4 ns, X"02" after 9 ns, X"FF" after 19 ns;
    monB <= X"02" after 4 ns;
    monCtrl_Alu <= "001" after 5 ns, "011" after 10 ns, "010" after 15 ns, "001" after 20 ns;

end Behavioral;