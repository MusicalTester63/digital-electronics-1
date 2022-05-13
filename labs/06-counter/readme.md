# Lab 6: David Hamran

### Bidirectional counter

## Preparation tasks (done before the lab at home)

The Nexys A7 board provides five push buttons for user applications.

1. See [schematic](https://github.com/tomas-fryza/digital-electronics-1/blob/master/Docs/nexys-a7-sch.pdf) or [reference manual](https://reference.digilentinc.com/reference/programmable-logic/nexys-a7/reference-manual) of the Nexys A7 board and find out the connection of these push buttons, ie to which FPGA pins are connected and how (schema). What logic/voltage value do the buttons generate when not pressed and what value when the buttons are pressed?

2. Calculate how many periods of clock signal with frequency of 100&nbsp;MHz contain time intervals 2&nbsp;ms, 4&nbsp;ms, 10&nbsp;ms, 250&nbsp;ms, 500&nbsp;ms, and 1&nbsp;s. Write values in decimal, binary, and hexadecimal forms.

   &nbsp;
   ![Clock period](images/freq.png)
   &nbsp;

   | **Time interval** | **Number of clk periods** | **Number of clk periods in hex** | **Number of clk periods in binary** |
   | :-: | :-: | :-: | :-: |
   | 2&nbsp;ms | 200 000 | `x"3_0d40"` | `b"0011_0000_1101_0100_0000"` |
   | 4&nbsp;ms | 400 000 | `x"6_1A80"` | `b"1100001101010000000"` |
   | 10&nbsp;ms | 1 000 000 | `x"F_4240 "` | `b"11110100001001000000"` |
   | 250&nbsp;ms | 25 000 000 | `x"17D_7840 "` | `b"1011111010111100001000000"` |
   | 500&nbsp;ms | 50 000 000 | `x"2FA_F080 "` | `b"10111110101111000010000000"` |
   | 1&nbsp;sec | 100 000 000 | `x"5F5_E100"` | `b"0101_1111_0101_1110_0001_0000_0000"` |
   
1. Listing of VHDL code of the completed process `p_cnt_up_down`. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
    --------------------------------------------------------
    -- p_cnt_up_down:
    -- Clocked process with synchronous reset which implements
    -- n-bit up/down counter.
    --------------------------------------------------------
    p_cnt_up_down : process(clk)
    begin
        if rising_edge(clk) then
        
            if (reset = '1') then   -- Synchronous reset
                s_cnt_local <= (others => '0'); -- Clear all bits

            elsif (en_i = '1') then -- Test if counter is enabled
               
                    if (cnt_up_i = '1') then
                        s_cnt_local <= s_cnt_local + 1;
                        
                    else 
                        s_cnt_local <= s_cnt_local - 1;
                    end if;
            end if;
        end if;
    end process p_cnt_up_down;
```

2. Screenshot with simulated time waveforms. Test reset as well. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

### Figure 1: Zoomed out screenshot
   ![Waveforms](images/waveforms.png)
### Figure 2: Testing reset
   ![reset](images/reset.png)
### Figure 3: Testing enable and reverse to counting down
   ![enable-and-downcount](images/enable_and_countdown.png)
### Figure 4: Testing stop(same signal as in figure 2(s_en))
   ![stoping-counter](images/stop.png)

### Two counters

1. Image of the top layer structure including both counters, ie a 4-bit bidirectional counter from *Part 4* and a 16-bit counter with a 10 ms time base from *Experiments on your own*. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

   ![16bit_counter](images/16_counter.png)
