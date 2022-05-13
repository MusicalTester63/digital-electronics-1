# Lab 5: David Hamran

### Flip-flops
## Preparation tasks (done before the lab at home)

1. Write characteristic equations and complete truth tables for D, JK, T flip-flops where `q(n)` represents main output value before the clock edge and `q(n+1)` represents output value after the clock edge.

   ![Characteristic equations](images/eq.png)

   <!--

	LaTeX editor
   https://editor.codecogs.com/
   -->

   **D-type FF**
   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 0 | `q(n+1)` has the same level as `d` |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 0 | `q(n+1)` has the same level as `d` |
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 1 | `q(n+1)` has the same level as `d` |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 1 | `q(n+1)` has the same level as `d` |

   **JK-type FF**
   | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 0 | 0 | Output did not change |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 1 | 1 | Output did not change |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 0 | 0 | Output got reset |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 1 | 0 | Output got reset |
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 0 | 1 | Output got set to 1|
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 1 | 1 | Output got set to 1 |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 0 | 1 | Output got reversed `q(n+1)`=not(`q(n)`) |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 1 | 0 | Output got reversed `q(n+1)`=not(`q(n)`) |

   **T-type FF**
   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](images/eq_uparrow.png) | 0 | 0 | 0 | `t=0` `q(n+1) = q(n)` |
   | ![rising](images/eq_uparrow.png) | 0 | 1 | 1 | `t=0` `q(n+1) = q(n)` |
   | ![rising](images/eq_uparrow.png) | 1 | 0 | 1 | `t=1` `q(n+1) = not(q(n))` |
   | ![rising](images/eq_uparrow.png) | 1 | 1 | 0 | `t=1` `q(n+1) = not(q(n))` |



1. Listing of VHDL architecture for T-type flip-flop. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture Behavioral of t_ff_rst is
    -- It must use this local signal instead of output ports
    -- because "out" ports cannot be read within the architecture
    signal s_q : std_logic;
begin
    --------------------------------------------------------
    -- p_t_ff_rst:
    -- T type flip-flop with a high-active synchro reset,
    -- rising-edge clk.
    -- q(n+1) = t./q(n) + /t.q(n)
    -- q(n+1) =  q(n) if t = 0 (no change)
    -- q(n+1) = /q(n) if t = 1 (inversion)
    --------------------------------------------------------
    p_t_ff_rst : process(clk)
    begin
        if rising_edge(clk) then

        if(rst='1') then
                s_q     <= '0';

            else
                s_q     <= (t and not(s_q)) or (not(t) and s_q);

            end if;  

        end if;
    end process p_t_ff_rst;

    -- Output ports are permanently connected to local signal
    q     <= s_q;
    q_bar <= not s_q;
end architecture Behavioral;
```

2. Screenshot with simulated time waveforms. Try to simulate both flip-flops in a single testbench with a maximum duration of 200 ns, including reset. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![your figure](images/simulation.png)

### Shift register

1. Image of the shift register `top` level schematic. The image can be drawn on a computer or by hand. Always name all inputs, outputs, components and internal signals!

   ![shiftregister](images/shift_register.png)
