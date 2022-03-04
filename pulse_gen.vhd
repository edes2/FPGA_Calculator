----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 11:09:55 AM
-- Design Name: 
-- Module Name: pulse_gen - Behavioral
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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity pulse_gen is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           gen_in : in STD_LOGIC;
           gen_out : out STD_LOGIC);
end pulse_gen;

ARCHITECTURE Behavioral OF pulse_gen IS

TYPE STATE IS (state_0,state_1,state_2);

SIGNAL CURRENT_STATE : STATE := state_0;


BEGIN

SEQ_PROC: PROCESS(clk, reset)
BEGIN

    IF(reset = '1') THEN
        CURRENT_STATE <= state_0;
    ELSIF(RISING_EDGE(CLK)) THEN
    
        CASE CURRENT_STATE IS
            when state_0 =>
		gen_out <= '0';
		if (gen_in='1') then
			CURRENT_STATE <= state_2;
	    end if;
	    when state_1 =>
		  gen_out <= '0';
          if (gen_in='0') then
            CURRENT_STATE <= state_0;
          end if;
        when state_2 =>
		        gen_out <= '1';
		        IF (gen_in='0') THEN
		          CURRENT_STATE <= state_0;
		        ELSIF(gen_in='1') THEN
		          CURRENT_STATE <= state_1;
                END IF;
        WHEN OTHERS =>
            CURRENT_STATE <= state_0;
        END CASE;
    END IF;
END PROCESS SEQ_PROC;


end Behavioral;
