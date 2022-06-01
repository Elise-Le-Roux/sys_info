----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.05.2022 11:39:30
-- Design Name: 
-- Module Name: Processeur - Behavioral
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

entity Processeur is
    Port ( OUTA : out STD_LOGIC_VECTOR (7 downto 0);
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
end Processeur;

architecture Behavioral of Processeur is

    component Memoire_instructions
        port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               OUTPUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component Banc_de_registres
        port ( Addr_A : in STD_LOGIC_VECTOR (3 downto 0);
               Addr_B : in STD_LOGIC_VECTOR (3 downto 0);
               Addr_W : in STD_LOGIC_VECTOR (3 downto 0);
               W : in STD_LOGIC;
               DATA : in STD_LOGIC_VECTOR (7 downto 0);
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               QA : out STD_LOGIC_VECTOR (7 downto 0);
               QB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component ALU
        port ( A : in STD_LOGIC_VECTOR (7 downto 0);
               B : in STD_LOGIC_VECTOR (7 downto 0);
               N : out STD_LOGIC;
               O : out STD_LOGIC;
               Z : out STD_LOGIC;
               C : out STD_LOGIC;
               Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
               S : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component Memoire_donnees
        port ( Addr : in STD_LOGIC_VECTOR (7 downto 0);
               INPUT : in STD_LOGIC_VECTOR (7 downto 0);
               RW : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               OUTPUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component pipeline1
        port ( inA : in STD_LOGIC_VECTOR (7 downto 0);
               inOP : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               inC : in STD_LOGIC_VECTOR (7 downto 0);
               outA : out STD_LOGIC_VECTOR (7 downto 0);
               outOP : out STD_LOGIC_VECTOR (7 downto 0);
               outB : out STD_LOGIC_VECTOR (7 downto 0);
               outC : out STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC);
    end component;
    
    component pipeline2
        port ( inA : in STD_LOGIC_VECTOR (7 downto 0);
               inOP : in STD_LOGIC_VECTOR (7 downto 0);
               inB : in STD_LOGIC_VECTOR (7 downto 0);
               outA : out STD_LOGIC_VECTOR (7 downto 0);
               outOP : out STD_LOGIC_VECTOR (7 downto 0);
               outB : out STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC);
    end component;
    
    -- Etage 1
    signal IP : STD_LOGIC_VECTOR (7 downto 0) := x"00"; -- pointeur d'instructions (compteur)
    signal INSTRUCT : STD_LOGIC_VECTOR (31 downto 0);
    
    -- Etage 2
    signal A1 : STD_LOGIC_VECTOR (7 downto 0);
    signal OP1 : STD_LOGIC_VECTOR (7 downto 0);
    signal B1 : STD_LOGIC_VECTOR (7 downto 0);
    signal C1 : STD_LOGIC_VECTOR (7 downto 0);
    signal OUT_MUX_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal QA : STD_LOGIC_VECTOR (7 downto 0);
    signal QB : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Etage 3
    signal A2 : STD_LOGIC_VECTOR (7 downto 0);
    signal OP2 : STD_LOGIC_VECTOR (7 downto 0);
    signal B2 : STD_LOGIC_VECTOR (7 downto 0);
    signal C2 : STD_LOGIC_VECTOR (7 downto 0);
    signal CTRL_ALU : STD_LOGIC_VECTOR (2 downto 0);
    signal OUT_MUX_2 : STD_LOGIC_VECTOR (7 downto 0);
    signal S : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Etage 4
    signal A3 : STD_LOGIC_VECTOR (7 downto 0);
    signal OP3 : STD_LOGIC_VECTOR (7 downto 0);
    signal B3 : STD_LOGIC_VECTOR (7 downto 0);
    signal OUT_MUX_3 : STD_LOGIC_VECTOR (7 downto 0);
    signal OUT_MUX_4 : STD_LOGIC_VECTOR (7 downto 0);
    signal RW : STD_LOGIC;
    signal OUTPUT : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Etage 5
    signal DATA : STD_LOGIC_VECTOR (7 downto 0);
    signal OP4 : STD_LOGIC_VECTOR (7 downto 0);
    signal ADDR_W : STD_LOGIC_VECTOR (7 downto 0);
    signal W : STD_LOGIC;  
    
    -- ALEA
    signal Alea : STD_LOGIC := '0';
    signal Alea_arithm : STD_LOGIC := '0';
    signal Alea_cop_store : STD_LOGIC := '0';

begin

----------------------- PORT MAP ----------------------- 

Mem_Ins : Memoire_instructions port map(IP,CK,INSTRUCT);

Banc : Banc_de_registres port map(B1(3 downto 0), C1(3 downto 0), ADDR_W(3 downto 0), W, DATA, RST, CK, QA, QB);
    
Mon_Alu : ALU port map(B2, C2, N, O, Z, C, CTRL_ALU, S);

Mem_Data : Memoire_donnees port map(OUT_MUX_3, B3, RW, RST, CK, OUTPUT);

--Pipeline_1 : pipeline1 port map(INSTRUCT(23 downto 16),INSTRUCT(31 downto 24),INSTRUCT(15 downto 8),INSTRUCT(7 downto 0), A1, OP1, B1, C1, CK);

Pipeline_2 : pipeline1 port map(A1, OP1, OUT_MUX_1, QB, A2, OP2, B2, C2, CK);

Pipeline_3 : pipeline2 port map(A2, OP2, OUT_MUX_2, A3, OP3, B3, CK);

Pipeline_4 : pipeline2 port map(A3, OP3, OUT_MUX_4, ADDR_W, OP4, DATA, CK);

-- pipeline 1
--process
--begin
    
--end process;

-- MULTIPLEXEURS
OUT_MUX_1 <= B1 when OP1=X"06" or OP1=X"07" else QA;
OUT_MUX_2 <= S when OP2=X"01" or OP2=X"02" or OP2=X"03" or OP2=X"04" else B2;
OUT_MUX_3 <= A3 when OP3=X"08" else
             B3;
OUT_MUX_4 <= OUTPUT when OP3=X"07" else B3;

-- LC
CTRL_ALU <= OP2(2 downto 0);
--RW <= '1' when OP3=X"07" else '0';
RW <= '0' when OP3=X"08" else '1';
W <= '0' when OP4=X"08" else '1';

-- ALEAS
-- ADD, MUL, DIV, SOU
Alea_arithm <= '1' when (INSTRUCT(31 downto 24)=x"01" or INSTRUCT(31 downto 24)=x"02" or INSTRUCT(31 downto 24)=x"03" or INSTRUCT(31 downto 24)=x"04") 
        and ((INSTRUCT(15 downto 8)=A1 and OP1/=x"08") or  (INSTRUCT(15 downto 8)=A2 and OP1/=x"08") or (INSTRUCT(15 downto 8)=A3 and OP1/=x"08")--B
        or (INSTRUCT(7 downto 0)=A1 and OP1/=x"08") or (INSTRUCT(7 downto 0)=A2 and OP1/=x"08") or (INSTRUCT(7 downto 0)=A3 and OP1/=x"08") ) --C
        else '0'; -- attention store
-- COPY
Alea_cop_store <= '1' when (INSTRUCT(31 downto 24)=x"05" or INSTRUCT(31 downto 24)=x"08") and 
        ((INSTRUCT(15 downto 8)=A1 and OP1/=x"08") or (INSTRUCT(15 downto 8)=A2 and OP1/=x"08") or (INSTRUCT(15 downto 8)=A3 and OP1/=x"08"))
        else '0';
        
Alea <= '1' when Alea_arithm='1' or Alea_cop_store='1'
        else '0';

-- SORTIE PROCESSEUR
OUTA <= QA;
OUTB <= QB;
OUT1 <= OP1;
OUT2 <= A1;
OUT3 <= B1;
OUT4 <= C1;
OUTS <= S;
OUT5 <= OP2;
OUT6 <= A2;
OUT7 <= B2;
OUT8 <= C2;
OUT9 <= OP3;
OUT10 <= A3;
OUT11 <= B3;
OUTINS <= INSTRUCT;
OUT_ADDR_W <= ADDR_W;
OUT_OP4 <= OP4;
OUT_DATA <= DATA;
OUT_LC <= W;
OUT_RW <= RW;
OUT_IP <= IP;

process
    begin
        wait for 40 ns;
        wait until CK'event and CK='1';
            if Alea = '0' then
                A1 <= INSTRUCT(23 downto 16);
                OP1 <= INSTRUCT(31 downto 24);
                B1 <= INSTRUCT(15 downto 8);
                C1 <= INSTRUCT(7 downto 0);
                IP <= IP + x"01";
            else
                A1 <= x"00";
                OP1 <= x"00";
                B1 <= x"00";
                C1 <= x"00";
            end if;
--                if INSTRUCT(31 downto 24) = x"01" and OP1=x"06" and (INSTRUCT(23 downto 16)=A1 or INSTRUCT(15 downto 8)=A1) then
--                    A1 <= x"00";
--                    OP1 <= x"00";
--                    B1 <= x"00";
--                    C1 <= x"00";
--                elsif INSTRUCT(31 downto 24) = x"01" and OP2=x"06" and (INSTRUCT(23 downto 16)=A2 or INSTRUCT(15 downto 8)=A2) then
--                    A1 <= x"00";
--                    OP1 <= x"00";
--                    B1 <= x"00";
--                    C1 <= x"00";
--                elsif INSTRUCT(31 downto 24) = x"01" and OP2=x"06" and (INSTRUCT(23 downto 16)=A3 or INSTRUCT(15 downto 8)=A3) then
--                    A1 <= x"00";
--                    OP1 <= x"00";
--                    B1 <= x"00";
--                    C1 <= x"00";
--                else
--                if OP2=x"06" and OP1=x"05" and A2=B1 then
--                    IP <= IP;
--                elsif OP2=x"06" and OP1=x"01" and (B1=A2 or C1=A2) then
--                    IP <= IP;
--                else
                  --if Alea='0' then
                    
                --  end if;
--                end if;
    end process;

end Behavioral;
