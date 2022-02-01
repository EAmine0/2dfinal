----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.01.2022 08:09:02
-- Design Name: 
-- Module Name: filtre_image - Behavioral
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


entity filtre_image is
Port (
        Din : IN  STD_LOGIC_VECTOR(7 downto 0);
		clk : IN  STD_LOGIC;
		reset : IN  STD_LOGIC;
		wr_en: IN STD_LOGIC;
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
		rd_en: OUT STD_LOGIC;
		Dout : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
end filtre_image;

architecture Behavioral of filtre_image is

	component fifo_generator_0
    port(
         clk : IN  std_logic;
         rst : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         wr_en : IN  std_logic;
         rd_en : IN  std_logic;
         prog_full_thresh : IN  std_logic_vector(9 downto 0);
         dout : OUT  std_logic_vector(7 downto 0);
         full : OUT  std_logic;
         almost_full : OUT  std_logic;
         empty : OUT  std_logic;
         prog_full : OUT  std_logic
        );
    end component;
	 
	component flipflop
		generic (Bus_Width: integer := 8);
		port (
		        D: IN STD_LOGIC_VECTOR (Bus_Width-1 downto 0); 
				Q: OUT STD_LOGIC_VECTOR (Bus_Width-1 downto 0);
				CLK: IN STD_LOGIC;
				EN: IN STD_LOGIC;
				RESET: IN STD_LOGIC);
	end component;
	
	component processing 
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
				en: in std_logic;
				sortie : out std_logic_vector(7 downto 0);
				reset : in std_logic;
				clk : in std_logic
			  );
	end component;
	
	signal temp1 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp2 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp3 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp4 : STD_LOGIC_VECTOR(7 downto 0);
	
	signal temp5 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp6 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp7 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp8 : STD_LOGIC_VECTOR(7 downto 0);
	
	signal temp9 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp10 : STD_LOGIC_VECTOR(7 downto 0);
	signal temp11 : STD_LOGIC_VECTOR(7 downto 0);
	
	constant prog_full_thresh0 :  STD_LOGIC_VECTOR(9 downto 0) := "00" & x"7B";
	constant prog_full_thresh1 :  STD_LOGIC_VECTOR(9 downto 0) := "00" & x"7B";
	
	signal wr_en0 : std_logic := '0';
    signal rd_en0 : std_logic := '0';
	signal full0 : std_logic;
    signal almost_full0 : std_logic;
    signal empty0 : std_logic;
    signal prog_full0 : std_logic;
	
	signal wr_en1 : std_logic := '0';
    signal rd_en1 : std_logic := '0';
	signal full1 : std_logic;
    signal almost_full1 : std_logic;
    signal empty1 : std_logic;
    signal prog_full1 : std_logic;

begin

	ff_0: flipflop generic map (8) port map (D => Din, Q => temp1, CLK => CLK, EN => '1', RESET => RESET);
	ff_1: flipflop generic map (8) port map (D => temp1, Q => temp2, CLK => CLK, EN => '1', RESET => RESET);
	ff_2: flipflop generic map (8) port map (D => temp2, Q => temp3, CLK => CLK, EN => '1', RESET => RESET);
	
	fif0: fifo_generator_0 port map(
	      clk => clk,
          rst => RESET,
          din => temp3,
          wr_en => '1',
          rd_en => prog_full0,
          prog_full_thresh => prog_full_thresh0,
          dout =>temp4,
          full => full0,
          almost_full => almost_full0,
          empty => empty0,
          prog_full => prog_full0);
			 
	ff_3: flipflop generic map (8) port map (D => temp4, Q => temp5, CLK => CLK, EN => '1', RESET => RESET);
	ff_4: flipflop generic map (8) port map (D => temp5, Q => temp6, CLK => CLK, EN => '1', RESET => RESET);
	ff_5: flipflop generic map (8) port map (D => temp6, Q => temp7, CLK => CLK, EN => '1', RESET => RESET);
	
	fif1: fifo_generator_0 port map(
	      clk => clk,
          rst => RESET,
          din => temp7,
          wr_en => '1',
          rd_en => prog_full1,
          prog_full_thresh => prog_full_thresh1,
          dout =>temp8,
          full => full1,
          almost_full => almost_full1,
          empty => empty1,
          prog_full => prog_full1);
			 
	ff_6: flipflop generic map (8) port map (D => temp8, Q => temp9, CLK => CLK, EN => '1', RESET => RESET);
	ff_7: flipflop generic map (8) port map (D => temp9, Q => temp10, CLK => CLK, EN => '1', RESET => RESET);
	ff_8: flipflop generic map (8) port map (D => temp10, Q => temp11, CLK => CLK, EN => '1', RESET => RESET);
	
	rd_en_proc: process(CLK, RESET)
	variable counter : integer := 0;
	begin
		if (RESET = '1') then
			counter := 0;
			rd_en <= '0';
		elsif rising_edge(clk) then
			if (wr_en = '1') then
				if (counter = 138) then
					rd_en <= '1';
				else
					counter := counter + 1;
				end if;
			end if;
			if (wr_en = '0') then
				if (counter = 0) then
					rd_en <= '0';
				else
					counter := counter - 1;
				end if;
			end if;
		end if;
	end process;

	processing_port: processing port map (
		pix1 => temp11,
		pix2 => temp10,
		pix3 => temp9,
		pix4 => temp7,
		pix5 => temp6,
		pix6 => temp5,
		pix7 => temp3,
		pix8 => temp2,
		pix9 => temp1,
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
		EN => '1',
		sortie => Dout,
		RESET => RESET,
		clk => clk);
	
end Behavioral;
