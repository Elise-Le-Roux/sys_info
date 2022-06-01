----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2022 15:02:25
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal Aux : std_logic_vector(15 downto 0);
begin
--    process (Ctrl_Alu, A, B)
--    begin
--        -- ADDITION
--        if Ctrl_Alu = X"01" then
--            Aux <= (X"00"&A) + (X"00"&B); 
            
--        -- MULTIPLICATION
--        elsif Ctrl_Alu = X"02" then
--            Aux <= A * B;
            
--        -- SOUSTRACTION
--        elsif Ctrl_Alu = X"03" then
--            Aux <= (X"00"&A) - (X"00"&B);
            
--        -- DIVISION
--        elsif Ctrl_Alu = X"04" then 
--            Aux <= shr(X"00"&A,x"1");
--        end if;
        
--    end process;

    Aux <=  -- ADDITION
            (X"00"&A) + (X"00"&B) when Ctrl_Alu = X"01" else
            
            -- MULTIPLICATION
            A * B when Ctrl_Alu = X"02" else
            
            -- SOUSTRACTION
            (X"00"&A) - (X"00"&B) when Ctrl_Alu = X"03" else
            
            -- DIVISION
            shr(X"00"&A,x"1") when Ctrl_Alu = X"04";
            
    N <= '1' when B > A and Ctrl_Alu = X"03" else '0';
    O <= '1' when Aux(15 downto 8) /= X"00" and Ctrl_Alu = X"02" else '0';
    Z <= '1' when Aux = X"0" else '0';
    C <= '1' when Aux(8) = '1' and Ctrl_Alu = X"01" else '0';
    S <= Aux(7 downto 0);
            
    
end Behavioral;
