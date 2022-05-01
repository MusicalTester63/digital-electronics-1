library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_mct is
    -- Entity of testbench is always empty
end entity tb_mct;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_mct is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    -- Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset : std_logic;
	
    signal s_data	:std_logic_vector(5 downto 0);
	
	signal s_dpout      : std_logic;
	
    signal s_seg        : std_logic_vector(6 downto 0);
    signal s_dig        : std_logic_vector(7 downto 0);



	signal s_start		:std_logic;
	
	signal s_rled		:std_logic_vector(2 downto 0);	
	signal s_lled		:std_logic_vector(2 downto 0);
	

begin
    uut_dri : entity work.mct
        port map (
		
		
            CLK100MHZ	=> s_clk_100MHz,
            BTNC		=> s_reset,
            
			
			
			
			SW  =>	s_data,
			
			CA	=>	s_seg(6),
			CB	=>	s_seg(5),
			CC	=>	s_seg(4),
			CD	=>	s_seg(3),
			CE	=>	s_seg(2),
			CF	=>	s_seg(1),
			CG	=>	s_seg(0),
			
			DP	=>	s_dpout,
						
            AN	=> s_dig,
			
			
			
			BTNR    =>	s_start,      --start button
			LED16_R =>	s_rled(2),    --RGB LEDs
			LED16_G =>	s_rled(1),
			LED16_B =>	s_rled(0),
			
			LED17_R =>	s_lled(2),
			LED17_G =>	s_lled(1),
			LED17_B =>	s_lled(0)
			
			
			
			
        );
    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    	
	p_clk_gen : process
    begin
        while now < 10000 ns loop -- 10 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
	
	

    --------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------
    p_reset_gen : process
    begin
        
        s_reset <= '1'; 
        wait for 70 ns;
        s_reset <= '0'; 
        wait;
    end process p_reset_gen;  


	--------------------------------------------------------
    -- Start transmitting
    --------------------------------------------------------
	p_start : process
	begin
	
		s_start <= '0';
		wait for 100 ns;
		s_start <= '1';
		wait for 20 ns;
		s_start <= '0';
		wait for 300 ns;

		s_start <= '1';
		wait for 20 ns;
		s_start <= '0';
		wait;
	end process p_start;




    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin
	
		s_data <= "000000";--a
        wait for 360 ns;
		
		
        s_data <= "000001";--b
        wait;
        
    end process p_stimulus;

end architecture testbench;
