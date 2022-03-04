library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity calculateur is
    Port ( mult : in STD_LOGIC;
           soust : in STD_LOGIC;
           add : in STD_LOGIC;
           div : in STD_LOGIC;
           reset : in STD_LOGIC;
           value_out : out STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC);
end calculateur;

architecture Behavioral of calculateur is
    type STATE is (state_0, state_1, state_2, state_3,
    state_4, state_5, state_6, state_7);
    
    signal CURRENT_STATE : STATE := state_0;
    
begin
SEQ_PROC: process(clk, reset)
begin
    IF(reset = '1') THEN
        CURRENT_STATE <= state_0;
    ELSIF(RISING_EDGE(clk))then
        CASE CURRENT_STATE IS
            WHEN state_0 => 
                value_out <= "000";
                if (add='1') then
                    CURRENT_STATE <= state_1;
                elsif (soust='1') then
                    CURRENT_STATE <= state_7;
                else CURRENT_STATE <= state_0;
                end if;
            when state_1 =>
                value_out <= "001";
                if (add='1') then
                    CURRENT_STATE <= state_2;
                elsif (soust='1') then
                    CURRENT_STATE <= state_0;
                elsif (mult='1') then
                    CURRENT_STATE <= state_2;
                elsif (div='1') then
                    CURRENT_STATE <= state_0;
                end if;
        when state_2 =>
            value_out <= "010";
            if (add='1') then
                CURRENT_STATE <= state_3;
            elsif (soust='1') then
                CURRENT_STATE <= state_1;
            elsif (mult='1') then
                CURRENT_STATE <= state_4;
            elsif (div='1') then
                CURRENT_STATE <= state_1;         
            end if;
        when state_3 =>
            value_out <= "011";
            if (add='1') then
                CURRENT_STATE <= state_4;
            elsif (soust='1') then
                CURRENT_STATE <= state_2;
            elsif (mult='1') then
                CURRENT_STATE <= state_6;
            elsif (div='1') then
                CURRENT_STATE <= state_1;
            end if;
        when state_4 =>
            value_out <= "100";
            if (add='1') then
                CURRENT_STATE <= state_5;
            elsif (soust='1') then
                CURRENT_STATE <= state_3;
            elsif (mult='1') then
                CURRENT_STATE <= state_0;
            elsif (div='1') then
                CURRENT_STATE <= state_2;
            end if;
        when state_5 =>
            value_out <= "101";
            if (add='1') then
                CURRENT_STATE <= state_6;
            elsif (soust='1') then
                CURRENT_STATE <= state_4;
            elsif (mult='1') then
                CURRENT_STATE <= state_2;
            elsif (div='1') then
                CURRENT_STATE <= state_2;
            end if;
        when state_6 =>
            value_out <= "110";
            if (add='1') then
                CURRENT_STATE <= state_7;
            elsif (soust='1') then
                CURRENT_STATE <= state_5;
            elsif (mult='1') then
                CURRENT_STATE <= state_4;
            elsif (div='1') then
                CURRENT_STATE <= state_3;
            end if;
        when state_7 =>
            value_out <= "111";
            if (add='1') then
                CURRENT_STATE <= state_0;
            elsif (soust='1') then
                CURRENT_STATE <= state_6;
            elsif (mult='1') then
                CURRENT_STATE <= state_6;
            elsif (div='1') then
                CURRENT_STATE <= state_3;
            end if;
        WHEN OTHERS =>
            CURRENT_STATE <= state_0;          
                    
        END CASE;
    end if;
end process;   
end Behavioral;