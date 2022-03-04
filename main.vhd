library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( clk : in STD_LOGIC;
           mult_in : in STD_LOGIC;
           add_in : in STD_LOGIC;
           div_in : in STD_LOGIC;
           sous_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           seven_seg : out STD_LOGIC_VECTOR (7 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is
    component DEBOUNCE
        port(
            clk, button: in STD_LOGIC;
            result: out STD_LOGIC
        );
    end component;
    
    component pulse_gen
        port(
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           gen_in : in STD_LOGIC;
           gen_out : out STD_LOGIC
        );
    end component;
    
    component calculateur
        port(
           mult : in STD_LOGIC;
           soust : in STD_LOGIC;
           add : in STD_LOGIC;
           div : in STD_LOGIC;
           reset : in STD_LOGIC;
           value_out : out STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC
        );
    end component;
    
    component seven_segment
        port(
           A : in STD_LOGIC_VECTOR (2 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    signal TMP_0_debounce: STD_LOGIC;
    signal TMP_1_debounce: STD_LOGIC;
    signal TMP_2_debounce: STD_LOGIC;
    signal TMP_3_debounce: STD_LOGIC;
    
    signal TMP_0_pulse_gen: STD_LOGIC;
    signal TMP_1_pulse_gen: STD_LOGIC;
    signal TMP_2_pulse_gen: STD_LOGIC;
    signal TMP_3_pulse_gen: STD_LOGIC;
    
    signal TMP_0_calculateur: STD_LOGIC_VECTOR (2 downto 0);
    
begin
    AN <= "11111110"; --0xFE
    
    --DEBOUNCE MODULES

    --PUSLE GEN MODULES
    U0: --multiplication
    DEBOUNCE port map(
        clk => clk, button=> mult_in, result => TMP_0_debounce
    );
    U1: --addition
        DEBOUNCE port map(
            clk => clk, button=> add_in, result => TMP_1_debounce
        );
    U2: --division
        DEBOUNCE port map(
            clk => clk, button=> div_in, result => TMP_2_debounce
        );
    U3: --soustraction
        DEBOUNCE port map(
            clk => clk, button=> sous_in, result => TMP_3_debounce
        );
    U4:
        pulse_gen port map(
            gen_in => TMP_0_debounce, 
            clk => clk, 
            reset=> reset, 
            gen_out => TMP_0_pulse_gen
        );
    U5:
        pulse_gen port map(
            gen_in => TMP_1_debounce, 
            clk => clk, 
            reset=> reset, 
            gen_out => TMP_1_pulse_gen
        );
    U6:
        pulse_gen port map(
            gen_in => TMP_2_debounce, 
            clk => clk, 
            reset=> reset, 
            gen_out => TMP_2_pulse_gen
        );
    U7:
        pulse_gen port map(
            gen_in => TMP_3_debounce, 
            clk => clk, 
            reset=> reset, 
            gen_out => TMP_3_pulse_gen
        );
    --CALCULATRICE MODULE
    U8:
        calculateur port map(
            mult  => TMP_0_pulse_gen,
            add => TMP_1_pulse_gen,
            div => TMP_2_pulse_gen,
            soust => TMP_3_pulse_gen,
            reset => reset,
            clk => clk,
            value_out => TMP_0_calculateur 
        );
    U9:
        seven_segment port map(
            A => TMP_0_calculateur,
            seven_seg => seven_seg
        );
   


end Behavioral;