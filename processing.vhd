----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2021 09:37:25
-- Design Name: 
-- Module Name: processing - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity processing is
port(
		pix1 : in std_logic_vector(7 downto 0);
		pix2 : in std_logic_vector(7 downto 0);
		pix3 : in std_logic_vector(7 downto 0);
		pix4 : in std_logic_vector(7 downto 0);
		pix5 : in std_logic_vector(7 downto 0);
		pix6 : in std_logic_vector(7 downto 0);
		pix7 : in std_logic_vector(7 downto 0);
		pix8 : in std_logic_vector(7 downto 0);
		pix9 : in std_logic_vector(7 downto 0);
		en: in std_logic;
		filtre_pix1 : in signed(3 downto 0);
		filtre_pix2 : in signed(3 downto 0);
		filtre_pix3 : in signed(3 downto 0);
		filtre_pix4 : in signed(3 downto 0);
		filtre_pix5 : in signed(3 downto 0);
		filtre_pix6 : in signed(3 downto 0);
		filtre_pix7 : in signed(3 downto 0);
		filtre_pix8 : in signed(3 downto 0);
		filtre_pix9 : in signed(3 downto 0);
		diviseur: in std_logic;
		sortie : out std_logic_vector(7 downto 0);
		reset : in std_logic;
		clk : in std_logic
	  );
end processing;

architecture Behavioral of processing is

component FlipFlop
	generic (Bus_Width: integer := 8);
	port (
	    D: IN STD_LOGIC_VECTOR (Bus_Width-1 downto 0); 
		Q: OUT STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
		clk: IN STD_LOGIC;
		en: IN STD_LOGIC;
		reset: IN STD_LOGIC);
end component;

signal add12 : signed(13 downto 0);
signal add34 : signed(13 downto 0);
signal add56 : signed(13 downto 0);
signal add78 : signed(13 downto 0);
signal add1234 : signed(14 downto 0);
signal add5678 : signed(14 downto 0);
signal add12345678 : signed(15 downto 0);
signal add123456789 : signed(16 downto 0);
signal absRes : signed(16 downto 0);

signal c1 : signed(12 downto 0);
signal c2 : signed(12 downto 0);
signal c3 : signed(12 downto 0);
signal c4 : signed(12 downto 0);
signal c5 : signed(12 downto 0);
signal c6 : signed(12 downto 0);
signal c7 : signed(12 downto 0);
signal c8 : signed(12 downto 0);
signal c9 : signed(12 downto 0);

signal cc1: std_logic_vector(12 downto 0);
signal cc2: std_logic_vector(12 downto 0);
signal cc3: std_logic_vector(12 downto 0);
signal cc4: std_logic_vector(12 downto 0);
signal cc5: std_logic_vector(12 downto 0);
signal cc6: std_logic_vector(12 downto 0);
signal cc7: std_logic_vector(12 downto 0);
signal cc8: std_logic_vector(12 downto 0);
signal cc9: std_logic_vector(12 downto 0);

signal FF91: std_logic_vector(12 downto 0);
signal FF92: std_logic_vector(12 downto 0);
signal FF93: std_logic_vector(12 downto 0);

-------------------------------------------------------

signal temp12 : std_logic_vector(13 downto 0);
signal temp34 : std_logic_vector(13 downto 0);


signal temp56 : std_logic_vector(13 downto 0);
signal temp78 : std_logic_vector(13 downto 0);


signal temp1234 : std_logic_vector(14 downto 0);
signal temp5678 : std_logic_vector(14 downto 0);

signal temp12345678 : std_logic_vector(15 downto 0);

signal tempc9: std_logic_vector(12 downto 0);
signal tempc9tempc9 : std_logic_vector(12 downto 0);
signal tempc9tempc9tempc9 : std_logic_vector(12 downto 0);

begin

	extra1: FlipFlop generic map(13) port map(D => std_logic_vector(c1), Q => cc1, CLK => CLK, EN => EN, RESET => RESET);
	extra2: FlipFlop generic map(13) port map(D => std_logic_vector(c2), Q => cc2, CLK => CLK, EN => EN, RESET => RESET);
	extra3: FlipFlop generic map(13) port map(D => std_logic_vector(c3), Q => cc3, CLK => CLK, EN => EN, RESET => RESET);
	extra4: FlipFlop generic map(13) port map(D => std_logic_vector(c4), Q => cc4, CLK => CLK, EN => EN, RESET => RESET);
	extra5: FlipFlop generic map(13) port map(D => std_logic_vector(c5), Q => cc5, CLK => CLK, EN => EN, RESET => RESET);
	extra6: FlipFlop generic map(13) port map(D => std_logic_vector(c6), Q => cc6, CLK => CLK, EN => EN, RESET => RESET);
	extra7: FlipFlop generic map(13) port map(D => std_logic_vector(c7), Q => cc7, CLK => CLK, EN => EN, RESET => RESET);
	extra8: FlipFlop generic map(13) port map(D => std_logic_vector(c8), Q => cc8, CLK => CLK, EN => EN, RESET => RESET);
	extra9: FlipFlop generic map(13) port map(D => std_logic_vector(c9), Q => cc9, CLK => CLK, EN => EN, RESET => RESET);

	
	extraFF9a: FlipFlop generic map(13) port map(D => std_logic_vector(cc9), Q => FF91, CLK => CLK, EN => EN, RESET => RESET);
	extraFF9b: FlipFlop generic map(13) port map(D => std_logic_vector(FF91), Q => FF92, CLK => CLK, EN => EN, RESET => RESET);
	extraFF9c: FlipFlop generic map(13) port map(D => std_logic_vector(FF92), Q => tempc9tempc9tempc9, CLK => CLK, EN => EN, RESET => RESET);

	add_proc: process(CLK)
	begin
		if rising_edge(CLK) then
			c1 <= filtre_pix1*signed("0" & pix1);
			c2 <= filtre_pix2*signed("0" & pix2);
			c3 <= filtre_pix3*signed("0" & pix3);
			c4 <= filtre_pix4*signed("0" & pix4);
			c5 <= filtre_pix5*signed("0" & pix5);
			c6 <= filtre_pix6*signed("0" & pix6);
			c7 <= filtre_pix7*signed("0" & pix7);
			c8 <= filtre_pix8*signed("0" & pix8);
			c9 <= filtre_pix9*signed("0" & pix9);

			add12 <= (cc1(cc1'left) & signed(cc1)) + (cc2(cc2'left) & signed(cc2));  
			add34 <= (cc3(cc3'left) & signed(cc3)) + (cc4(cc4'left) & signed(cc4));
			add56 <= (cc5(cc5'left) & signed(cc5)) + (cc6(cc6'left) & signed(cc6));
			add78 <= (cc7(cc7'left) & signed(cc7)) + (cc8(cc8'left) & signed(cc8));

			add1234 <= (add12(add12'left) & signed(add12)) + (add34(add34'left) & signed(add34));
			add5678 <= (add56(add56'left) & signed(add56)) + (add78(add78'left) & signed(add78));

			add12345678 <= (add1234(add1234'left) & signed(add1234)) + (add5678(add5678'left) & signed(add5678));

			add123456789 <= (add12345678(add12345678'left) & signed(add12345678)) + 
			(tempc9tempc9tempc9(tempc9tempc9tempc9'left) & tempc9tempc9tempc9(tempc9tempc9tempc9'left) & 
			tempc9tempc9tempc9(tempc9tempc9tempc9'left) & tempc9tempc9tempc9(tempc9tempc9tempc9'left) & 
			signed(tempc9tempc9tempc9));
		end if;
		
			absRes <= (abs(add123456789));
		
	end process;
	
	
	
	sortie <= std_logic_vector(absRes(9 downto 2)) when diviseur = '1' else	
					std_logic_vector(absRes(10 downto 3));

end Behavioral;
