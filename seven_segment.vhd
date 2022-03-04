----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2021 11:39:55 AM
-- Design Name: 
-- Module Name: seven_segment - Behavioral
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

entity seven_segment is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           seven_seg : out STD_LOGIC_VECTOR (7 downto 0));
end seven_segment;

architecture Behavioral of seven_segment is

begin
    seven_seg <= "11000000" WHEN A = "000" ELSE
                 "11111001" WHEN A = "001" ELSE
                 "10100100" WHEN A = "010" ELSE
                 "10110000" WHEN A = "011" ELSE
                 "10011001" WHEN A = "100" ELSE
                 "10010010" WHEN A = "101" ELSE
                 "10000010" WHEN A = "110" ELSE
                 "11111000" WHEN A = "111"
                 ;
end Behavioral;
