-- Inclusão da biblioteca IEEE necessária
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declaração da entidade do somador completo
entity FullAdder is
    Port ( A    : in  STD_LOGIC;  -- Entrada A
           B    : in  STD_LOGIC;  -- Entrada B
           Cin  : in  STD_LOGIC;  -- Carry-in
           Sum  : out STD_LOGIC;  -- Saída da soma
           Cout : out STD_LOGIC   -- Carry-out
           );
end FullAdder;

-- Arquitetura do somador completo
architecture Behavioral of FullAdder is
begin
    -- Processo para calcular a soma e o carry-out
    process (A, B, Cin)
    begin
        Sum  <= (A xor B) xor Cin;   -- Soma é a XOR de A, B e Cin
        Cout <= (A and B) or (Cin and (A xor B));  -- Carry-out
    end process;
end Behavioral;
