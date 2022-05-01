----------------------------------------------------------------------------------
-- Company: Brno University of Technology
-- Engineer: David Hamran
-- 
-- Module Name: mct - Behavioral
-- Project Name: Morse code transmitter
-- Target Devices: Nexys A7-50T
-- 
-- Dependencies: transmitter, morse_display_driver
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mct is
	Port (	
		
		CLK100MHZ : in STD_LOGIC;	--clock
	
		SW : in STD_LOGIC_VECTOR (5 downto 0);	--switches for data input
        CA : out STD_LOGIC;						--cathodes for 7-seg display
        CB : out STD_LOGIC;
        CC : out STD_LOGIC;
        CD : out STD_LOGIC;
        CE : out STD_LOGIC;
        CF : out STD_LOGIC;
        CG : out STD_LOGIC;
        DP : out STD_LOGIC;
        AN : out STD_LOGIC_VECTOR (7 downto 0);	--common anodes connection
	
		
		BTNR :	in STD_LOGIC;		--start button
        LED16_R : out STD_LOGIC;	--RGB LEDs
        LED16_G : out STD_LOGIC;
        LED16_B : out STD_LOGIC;
		
        LED17_R : out STD_LOGIC;
        LED17_G : out STD_LOGIC;
        LED17_B : out STD_LOGIC;
		
		
		BTNC : in STD_LOGIC	--reset button
	);
end mct;



architecture Behavioral of mct is

	begin
	
	
	-- Instance (copy) of transmitter entity
    transmitter : entity work.transmitter
        port map(
		
            clk   => CLK100MHZ,
            reset => BTNC,
			
			
			data_i(5)	=>	SW(5),
			data_i(4)	=>	SW(4),
			data_i(3)	=>	SW(3),
			data_i(2)	=>	SW(2),
			data_i(1)	=>	SW(1),
			data_i(0)	=>	SW(0),
			
			
			start_i	=>	BTNR,
			
            transmitter_o(2) => LED17_R,
            transmitter_o(1) => LED17_G,
            transmitter_o(0) => LED17_B,
			
			
			state_o(2) => LED16_R,
            state_o(1) => LED16_G,
            state_o(0) => LED16_B
        );
	
	
	
	
	 --------------------------------------------------------
  -- Instance (copy) of driver_7seg_8digits entity
	morse_display_driver: entity work.driver_7seg_8digits
      port map(
	  
        clk        => CLK100MHZ,
        reset      => BTNC,
		  
        data_i(5)	=>	SW(5),
		data_i(4)	=>	SW(4),
		data_i(3)	=>	SW(3),
		data_i(2)	=>	SW(2),
		data_i(1)	=>	SW(1),
		data_i(0)	=>	SW(0),
  
        dp_o => DP,
		
		
		
        seg_o(6) => CA,
        seg_o(5) => CB,
        seg_o(4) => CC,
        seg_o(3) => CD,
        seg_o(2) => CE,
        seg_o(1) => CF,
        seg_o(0) => CG,
		
		dig_o(7 downto 0) => AN(7 downto 0)


      );

	end Behavioral;
