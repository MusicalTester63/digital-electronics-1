library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_Multiplexer is    
end entity tb_Multiplexer;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_Multiplexer is

    -- Local signals
    signal s_sel_i           : std_logic_vector(1 downto 0);
    signal s_f_o             : std_logic_vector(2 downto 0);
    signal s_a_i             : std_logic_vector(2 downto 0);
    signal s_b_i             : std_logic_vector(2 downto 0);
    signal s_c_i             : std_logic_vector(2 downto 0);
    signal s_d_i             : std_logic_vector(2 downto 0);

begin
uut_Multiplexer : entity work.Multiplexer
        port map(
        
            sel_i	=>	s_sel_i,
            f_o     =>	s_f_o,
            
        	a_i    	=>	s_a_i,
         	b_i    	=>	s_b_i,
         	c_i    	=>	s_c_i,
         	d_i    	=>	s_d_i
         	
        
        );

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
    p_stimulus : process
    begin    
    
        report "Stimulus process started" severity note;
		
        --Will report error but comparator works              
     
        
        
        
        wait; 
        
    end process p_stimulus;

end architecture testbench;
