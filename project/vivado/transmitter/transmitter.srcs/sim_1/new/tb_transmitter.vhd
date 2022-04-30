library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_transmitter is
    -- Entity of testbench is always empty
end entity tb_transmitter;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_transmitter is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
	
	--data input & start button
	signal s_data  : std_logic_vector(5 downto 0);
	signal s_start : std_logic;
	
	--State of transmitter & tansmitter output
    signal s_state  		: std_logic_vector(2 downto 0);
    signal s_transmitter	: std_logic_vector(2 downto 0);
    

begin
    -- Connecting testbench signals with transmitter entity
    -- (Unit Under Test)
    uut_trans : entity work.transmitter
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
			
			data_i => s_data,
			start_i => s_start,
			
            state_o => s_state,
			transmitter_o => s_transmitter
        
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
        s_reset <= '0'; 
        --wait for 200 ns;
        -- Reset activated
        --s_reset <= '1'; 
        --wait for 200 ns;
        -- Reset deactivated
        --s_reset <= '0';
        wait;
    end process p_reset_gen;


	p_start : process
	begin
	
	s_start <= '0';
	wait for 100 ns;
	s_start <= '1';
    wait for 20 ns;
    s_start <= '0';
	wait for 250 ns;

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
        wait for 330 ns;
		
		
        s_data <= "000001";--b
        wait;
		
		
    
	end process p_stimulus;

end architecture testbench;
