-- Inclusão da biblioteca IEEE necessária
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Declaração da entidade da ULA
entity ULA_4bits is
    Port ( A0, A1, A2, A3 : in  STD_LOGIC;  -- Bits individuais da entrada A
           B0, B1, B2, B3 : in  STD_LOGIC;  -- Bits individuais da entrada B
           OP0, OP1       : in  STD_LOGIC;  -- Bits individuais do seletor de operação
           R0, R1, R2, R3 : out STD_LOGIC;  -- Bits individuais da saída R
           Cout           : out STD_LOGIC;  -- Carry-out da soma
           Bout           : out STD_LOGIC   -- Borrow-out da subtração
         );
end ULA_4bits;

-- Arquitetura da ULA
architecture Behavioral of ULA_4bits is
    signal A, B, R : STD_LOGIC_VECTOR(3 downto 0);
    signal OP      : STD_LOGIC_VECTOR(1 downto 0);
    signal temp_sum, temp_sub : STD_LOGIC_VECTOR (4 downto 0);
begin
    -- Agrupando bits individuais em vetores para operações internas
    A  <= (A3, A2, A1, A0);
    B  <= (B3, B2, B1, B0);
    OP <= (OP1, OP0);

    process (A, B, OP)
    begin
        case OP is
            when "00" =>  -- Soma (A + B)
                temp_sum <= ('0' & A) + ('0' & B);  -- Correção: usando "<="
                R    <= temp_sum(3 downto 0);
                Cout <= temp_sum(4);
                Bout <= '0';  

            when "01" =>  -- Subtração (A - B)
                temp_sub <= ('0' & A) - ('0' & B);  -- Correção: usando "<="
                R    <= temp_sub(3 downto 0);
                Cout <= '0';
                Bout <= temp_sub(4);

            when "10" =>  -- AND lógico (A AND B)
                R    <= A AND B;
                Cout <= '0';
                Bout <= '0';

            when "11" =>  -- OR lógico (A OR B)
                R    <= A OR B;
                Cout <= '0';
                Bout <= '0';

            when others =>
                R    <= "0000"; 
                Cout <= '0';
                Bout <= '0';
        end case;
    end process;

    -- Expandindo a saída R para bits individuais
    R0 <= R(0);
    R1 <= R(1);
    R2 <= R(2);
    R3 <= R(3);
end Behavioral;
