library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------
-- Entity declaration for morse transmitter
------------------------------------------------------------
entity transmitter is
    port(
		
		--clock & reset
        clk     : in  std_logic;
        reset   : in  std_logic;
        
		--data input & start button
        data_i 		: in std_logic_vector (5 downto 0);
		start_i     : in std_logic;
        
        --State & output 
		state_o         :out std_logic_vector(2 downto 0);
        transmitter_o   :out std_logic_vector(2 downto 0)
        
    );
end entity transmitter;

------------------------------------------------------------
-- Architecture declaration for transmitter
------------------------------------------------------------
architecture Behavioral of transmitter is

    --Define the states
	type t_state is (INPUTTING,TRANSMITTING);
	type led_state is (START,CHAR0,CHAR1,CHAR2,CHAR3,CHAR4,CHAR5,PAUSE0,PAUSE1,PAUSE2,PAUSE3,PAUSE4,PAUSE5);
    
	
	--Define the signal that uses different states
    signal s_t_state : t_state;
	signal s_led_state : led_state;


    --Internal clock enable
    signal s_en : std_logic;
	
	signal s_data : std_logic_vector(5 downto 0);
	signal s_data_length : std_logic_vector(5 downto 0);


    --Local delay counter
    signal s_cnt : unsigned(4 downto 0);


    --Specific values for local counter
    constant c_DELAY_1SEC : unsigned(4 downto 0) := b"0_0100";--(START,DOT,PAUSE)	
	constant c_DELAY_2SEC : unsigned(4 downto 0) := b"0_1000";--(DASH)
    constant c_DELAY_3SEC : unsigned(4 downto 0) := b"0_1000"; 
	constant c_DELAY_4SEC : unsigned(4 downto 0) := b"1_0000";
    constant c_ZERO       : unsigned(4 downto 0) := b"0_0000";


    --Output values
	constant c_OFF		: std_logic_vector(2 downto 0)	:= b"000";		--off(START,PAUSE)
    constant c_RED		: std_logic_vector(2 downto 0)	:= b"100";		--RED(STATE)
    constant c_GREEN	: std_logic_vector(2 downto 0)	:= b"010";		--GREEN shines green(DOT,DASH)
	constant c_BLUE		: std_logic_vector(2 downto 0)	:= b"001";		--BLUE(UNUSED)
	constant c_YELLOW	: std_logic_vector(2 downto 0)	:= b"110";		--YELLOW(STATE)
	
	
begin



    --------------------------------------------------------
    -- Instance (copy) of clock_enable entity generates 
    -- an enable pulse every 250 ms (4 Hz). Remember that 
    -- the frequency of the clock signal is 100 MHz.
	--------------------------------------------------------
	
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 1  -- 1 FOR SIMULATION PURPOSE ONLY !!!
                        -- FOR IMPLEMENTATION: g_MAX = 250 ms(25000000) / (1/100 MHz)
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

	
	translator : entity work.translator
	
		port map (		
			
		
			data_i => data_i,
			
			data_o => s_data,
			length_o => s_data_length
		
		
		);


    --------------------------------------------------------
    -- p_transmitter_FSM:
    -- The sequential process with synchronous reset and 
    -- clock_enable entirely controls the s_t_state signal by 
    -- CASE statement.
    --------------------------------------------------------
    p_transmitter_FSM : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then   -- Synchronous reset
                s_t_state <= INPUTTING;   -- Set initial state
				s_led_state <= START;
                s_cnt   <= c_ZERO;  -- Clear delay counter

            elsif (s_en = '1') then
			
                -- Every 250 ms, CASE checks the value of the s_t_state
                -- variable and changes to the next state according 
                -- to the delay value.
                case s_t_state is
											
                    -- If the current state is INPUTTING, then wait for start_i
                    -- to become '1' and move to state TRANSMITTING.
                    when INPUTTING =>
					
                        if(start_i /= '1') then
						
						else
							s_t_state <= TRANSMITTING;
							s_cnt <= c_ZERO;
						end if;



                    when TRANSMITTING =>  
					
					
					-- DOT=1, DASH=0
						case s_led_state is
						
							
							when START =>
							
								if (s_cnt < c_DELAY_1SEC) then
									s_cnt <= s_cnt + 1;
								else
									-- Move to the next state if next length bit is '1' else end transmission
									if(s_data_length(5) = '1') then
										s_led_state <= CHAR0;
									else
										-- END OF TRANSMISSION 
										s_led_state <= START;
										s_t_state <= INPUTTING;
									end if;
									-- Reset local counter value
									s_cnt <= c_ZERO;
								end if;
						
						
						
						--FIRST CHARACTER
							when CHAR0 =>							
							
								if(s_data(5) = '1') then
									
									if (s_cnt < c_DELAY_1SEC) then
										s_cnt <= s_cnt + 1;
									else
										-- Move to the next state if next length bit is '1' else end transmission
										if(s_data_length(4) = '1') then
											s_led_state <= PAUSE0;
										else
											-- END OF TRANSMISSION 
											s_led_state <= START;
											s_t_state <= INPUTTING;
										
										end if;
									-- Reset local counter value
									s_cnt <= c_ZERO;
									end if;
									
									
								elsif(s_data(5) = '0') then
									if (s_cnt < c_DELAY_2SEC) then
										s_cnt <= s_cnt + 1;
									else
										-- Move to the next state if next length bit is '1' else end transmission
										if(s_data_length(4) = '1') then
											s_led_state <= PAUSE0;
										else
											-- END OF TRANSMISSION 
											s_led_state <= START;
											s_t_state <= INPUTTING;
										
										end if;
									-- Reset local counter value
									s_cnt <= c_ZERO;
									end if;
								end if;
								
								
							
							when PAUSE0 =>
		
								if (s_cnt < c_DELAY_1SEC) then
									s_cnt <= s_cnt + 1;
								else
									-- Move to the next state if next length bit is '1' else end transmission
									if(s_data_length(4) = '1') then		
									
										s_led_state <= CHAR1;
									
									else
										-- END OF TRANSMISSION 
										s_led_state <= START;
										s_t_state <= INPUTTING;
									end if;
								-- Reset local counter value
								s_cnt <= c_ZERO;
								end if;
								
								
								
								
						--SECOND CHARACTER
							when CHAR1 =>
							
								if(s_data(4) = '1') then
									
									if (s_cnt < c_DELAY_1SEC) then
										s_cnt <= s_cnt + 1;
									else
										-- Move to the next state if next length bit is '1' else end transmission
										if(s_data_length(3) = '1') then
											s_led_state <= PAUSE1;
										else
											-- END OF TRANSMISSION 
											s_led_state <= START;
											s_t_state <= INPUTTING;
										
										end if;
									-- Reset local counter value
									s_cnt <= c_ZERO;
									end if;
									
									
								elsif(s_data(4) = '0') then
									if (s_cnt < c_DELAY_2SEC) then
										s_cnt <= s_cnt + 1;
									else
										-- Move to the next state if next length bit is '1' else end transmission
										if(s_data_length(3) = '1') then
											s_led_state <= PAUSE1;
										else
											-- END OF TRANSMISSION 
											s_led_state <= START;
											s_t_state <= INPUTTING;
										
										end if;
									-- Reset local counter value
									s_cnt <= c_ZERO;
									end if;
								end if;
							
							when PAUSE1 =>
		
								if (s_cnt < c_DELAY_1SEC) then
									s_cnt <= s_cnt + 1;
								else
									-- Move to the next state if next length bit is '1' else end transmission
									if(s_data_length(3) = '1') then		
									
										s_led_state <= CHAR2;
									
									else
										-- END OF TRANSMISSION 
										s_led_state <= START;
										s_t_state <= INPUTTING;
									end if;
								-- Reset local counter value
								s_cnt <= c_ZERO;
								end if;
							
						
						--THIRD CHARACTER
							when CHAR2 =>							
							
								if(s_data_length(3) = '1') then
									if(s_data(3) = '1') then
									
										if (s_cnt < c_DELAY_1SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- Move to the next state if next length bit is '1' else end transmission
											if(s_data_length(2) = '1') then
												s_led_state <= PAUSE2;
											else
												-- END OF TRANSMISSION 
												s_led_state <= START;
												s_t_state <= INPUTTING;
													
											end if;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;
										
										
									elsif(s_data(3) = '0') then
											
										if (s_cnt < c_DELAY_2SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- Move to the next state if next length bit is '1' else end transmission
											if(s_data_length(2) = '1') then
												s_led_state <= PAUSE2;
											else
												-- END OF TRANSMISSION 
												s_led_state <= START;
												s_t_state <= INPUTTING;
													
											end if;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;
									end if;
								else
								
									-- END OF TRANSMISSION 
									s_led_state <= START;
									s_t_state <= INPUTTING;
									-- Reset local counter value
									s_cnt <= c_ZERO;								
								
								end if;
							
							
							
							when PAUSE2 =>
		
								if (s_cnt < c_DELAY_1SEC) then
									s_cnt <= s_cnt + 1;
								else
									-- Move to the next state if next length bit is '1' else end transmission
									if(s_data_length(3) = '1') then		
									
										s_led_state <= CHAR3;
									
									else
										-- END OF TRANSMISSION 
										s_led_state <= START;
										s_t_state <= INPUTTING;
									end if;
								-- Reset local counter value
								s_cnt <= c_ZERO;
								end if;
							
							
							
							
							
							
							
						
						--FOURTH CHARACTER
							when CHAR3 =>
							
								if(s_data_length(2) = '1') then
									if(s_data(2) = '1') then
									
										if (s_cnt < c_DELAY_1SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- Move to the next state if next length bit is '1' else end transmission
											if(s_data_length(1) = '1') then
												s_led_state <= PAUSE3;
											else
												-- END OF TRANSMISSION 
												s_led_state <= START;
												s_t_state <= INPUTTING;
													
											end if;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;
										
										
									elsif(s_data(2) = '0') then
											
										if (s_cnt < c_DELAY_2SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- Move to the next state if next length bit is '1' else end transmission
											if(s_data_length(1) = '1') then
												s_led_state <= PAUSE3;
											else
												-- END OF TRANSMISSION 
												s_led_state <= START;
												s_t_state <= INPUTTING;
													
											end if;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;
									end if;
								else
								
									-- END OF TRANSMISSION 
									s_led_state <= START;
									s_t_state <= INPUTTING;
									-- Reset local counter value
									s_cnt <= c_ZERO;								
								
								end if;
							
							
							when PAUSE3 =>
		
								if (s_cnt < c_DELAY_1SEC) then
									s_cnt <= s_cnt + 1;
								else
									-- Move to the next state if next length bit is '1' else end transmission
									if(s_data_length(3) = '1') then		
									
										s_led_state <= CHAR4;
									
									else
										-- END OF TRANSMISSION 
										s_led_state <= START;
										s_t_state <= INPUTTING;
									end if;
								-- Reset local counter value
								s_cnt <= c_ZERO;
								end if;
							
							
							
							
							
							
							
						--FIFTH CHARACTER
							when CHAR4 =>
						
						
								if(s_data_length(1) = '1') then
									if(s_data(1) = '1') then
									
										if (s_cnt < c_DELAY_1SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- Move to the next state if next length bit is '1' else end transmission
											if(s_data_length(0) = '1') then
												s_led_state <= PAUSE4;
											else
												-- END OF TRANSMISSION 
												s_led_state <= START;
												s_t_state <= INPUTTING;
													
											end if;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;
										
										
									elsif(s_data(1) = '0') then
											
										if (s_cnt < c_DELAY_2SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- Move to the next state if next length bit is '1' else end transmission
											if(s_data_length(0) = '1') then
												s_led_state <= PAUSE4;
											else
												-- END OF TRANSMISSION 
												s_led_state <= START;
												s_t_state <= INPUTTING;
													
											end if;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;
									end if;
								end if;
								
								
							when PAUSE4 =>
		
								if (s_cnt < c_DELAY_1SEC) then
									s_cnt <= s_cnt + 1;
								else
									-- Move to the next state if next length bit is '1' else end transmission
									if(s_data_length(3) = '1') then		
									
										s_led_state <= CHAR5;
									
									else
										-- END OF TRANSMISSION 
										s_led_state <= START;
										s_t_state <= INPUTTING;
									end if;
								-- Reset local counter value
								s_cnt <= c_ZERO;
								end if;		
							
							
						
						
					--SIXTH CHARACTER
							when CHAR5 =>
							
								if(s_data_length(0) = '1') then
									if(s_data(0) = '1') then
									
										if (s_cnt < c_DELAY_1SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- END OF TRANSMISSION 
											s_led_state <= START;
											s_t_state <= INPUTTING;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;
										
										
									elsif(s_data(0) = '0') then
											
										if (s_cnt < c_DELAY_2SEC) then
											s_cnt <= s_cnt + 1;
										else
											-- END OF TRANSMISSION 
											s_led_state <= START;
											s_t_state <= INPUTTING;
											-- Reset local counter value
											s_cnt <= c_ZERO;
										end if;												
									end if;
								end if;
							
							
								
								
								
							when others  =>	
								s_t_state <= INPUTTING;
								s_led_state <= START;
								s_cnt   <= c_ZERO;								
								
						
						end case;
						
					
						
                    -- It is a good programming practice to use the 
                    -- OTHERS clause, even if all CASE choices have 
                    -- been made.
                    when others =>
                        s_t_state <= INPUTTING;
						s_led_state <= CHAR0;
                        s_cnt   <= c_ZERO;
                        
                        
                end case;
                
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_transmitter_FSM;


--LLED
    p_transmitter_output : process(s_led_state)
    begin
        case s_led_state is
		
			when START =>
			
				transmitter_o <= c_OFF;
		
		
            when CHAR0 =>
			
                transmitter_o <= c_GREEN;
			
            when CHAR1 =>

				transmitter_o <= c_GREEN;
			
			when CHAR2 =>
			
                transmitter_o <= c_GREEN;
			
            when CHAR3 =>

				transmitter_o <= c_GREEN;
			
			when CHAR4 =>
			
                transmitter_o <= c_GREEN;
			
            when CHAR5 =>

				transmitter_o <= c_GREEN;

			when others =>
			
				transmitter_o <= c_OFF;
			
			
        end case;
    end process p_transmitter_output;


--RLED
    p_transmitter_state_output : process(s_t_state)
    begin
        case s_t_state is
		
            when INPUTTING =>			
                
                state_o <= c_RED;
            
            when TRANSMITTING =>

				state_o <= c_YELLOW;
				
			when others =>
			
				state_o <= c_OFF;
			
        end case;
    end process p_transmitter_state_output;


end architecture Behavioral;
