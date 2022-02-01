----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2021 08:21:03
-- Design Name: 
-- Module Name: flipflop - Behavioral
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


entity flipflop is

generic (Bus_Width : integer := 8);
    Port (
             D: IN STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
			 Q: OUT STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
			 clk: IN STD_LOGIC;
			 en: IN STD_LOGIC;
			 reset: IN STD_LOGIC);
end flipflop;

architecture Behavioral of flipflop is

signal temp : STD_LOGIC_VECTOR (Bus_Width-1 downto 0) := (others => '0');

begin

ff: process (clk,reset)
begin

	if (reset ='1') then temp <= (others => '0');
	elsif rising_edge(clk)
	then
		if ( en = '1') then
			temp <= D;
		else
			temp <= (others => '0');
		end if;
	end if;

end process ff;

Q <= temp;

end Behavioral;
