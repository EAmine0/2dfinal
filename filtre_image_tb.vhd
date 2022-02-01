----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.01.2022 08:09:30
-- Design Name: 
-- Module Name: filtre_image_tb - Behavioral
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
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;
use IEEE.NUMERIC_STD.ALL;
 
 
ENTITY filtre_image_tb IS
END filtre_image_tb;
 
ARCHITECTURE behavior OF filtre_image_tb IS 
 
 
    COMPONENT filtre_image 
    PORT(
            Din : IN  std_logic_vector(7 downto 0);
            clk : IN  std_logic;
			WR_EN: IN STD_LOGIC;
            reset : IN  std_logic;
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
			RD_EN: OUT STD_LOGIC;
            Dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   signal Din : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal WR_EN: std_logic := '0';
   signal reset : std_logic := '0';
   signal diviseur : std_logic := '0';
   
   signal filtre_pix1 : signed(3 downto 0) := x"1";
   signal filtre_pix2 : signed(3 downto 0) := x"1";
   signal filtre_pix3 : signed(3 downto 0) := x"1";
   signal filtre_pix4 : signed(3 downto 0) := x"0";
   signal filtre_pix5 : signed(3 downto 0) := x"0";
   signal filtre_pix6 : signed(3 downto 0) := x"0";
   signal filtre_pix7 : signed(3 downto 0) := x"1";
   signal filtre_pix8 : signed(3 downto 0) := x"1";
   signal filtre_pix9 : signed(3 downto 0) := x"1";
   

   signal Dout : std_logic_vector(7 downto 0);
   signal RD_EN:  std_logic;
	

   constant CLK_period : time := 10 ns;
 
BEGIN
 
   uut: filtre_image PORT MAP (
				Din => Din,
				clk => clk,
				WR_EN => WR_EN,
				filtre_pix1 => filtre_pix1,
				filtre_pix2 => filtre_pix2,
				filtre_pix3 => filtre_pix3,
				filtre_pix4 => filtre_pix4,
				filtre_pix5 => filtre_pix5,
				filtre_pix6 => filtre_pix6,
				filtre_pix7 => filtre_pix7,
				filtre_pix8 => filtre_pix8,
				filtre_pix9 => filtre_pix9,
				diviseur => diviseur,
				RD_EN => RD_EN,
				RESET => RESET,
				Dout => Dout
        );


   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	
	rst_proc : process
	begin
		RESET <= '1';
		wait for clk_period * 5;
		RESET <= '0';
		wait for clk_period * 5;
		wait;
	end process;


   read_proc: process
   FILE vectors : text;
   variable linein : line;
   variable linein_var :std_logic_vector (7 downto 0);
   begin
		wait for clk_period * 10;
		wait for clk_period * 1;
		
		wr_en <= '1';
		file_open (vectors,"Lena128x128g_8bits.dat", read_mode);
		while not endfile(vectors) loop
			readline (vectors,linein);
			read (linein, linein_var);
			din <= linein_var;
			wait for clk_period * 1;
		end loop;
		file_close (vectors);
		wr_en <= '0';
		wait;
   end process;
	
	write_proc: process
   FILE results : text;
   variable lineout : line;
   variable lineout_var :std_logic_vector (7 downto 0);
   begin
		wait for clk_period * 10;
		
		while rd_en = '0' loop
			wait for clk_period * 1;
		end loop;
		
		file_open (results,"Lena128x128g_8bits_r2.dat", write_mode);
		while rd_en = '1' loop
			wait for clk_period * 1;
			lineout_var := dout;
			write (lineout,lineout_var);
			writeline (results,lineout);
		end loop;
		file_close (results);
   end process;
   

END;
