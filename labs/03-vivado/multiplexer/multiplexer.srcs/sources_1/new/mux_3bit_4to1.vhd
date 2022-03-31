library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for 4-bit binary comparator
------------------------------------------------------------
entity Multiplexer is
    port(
    
    
       sel_i: in std_logic_vector(1 downto 0);
         f_o: out std_logic_vector(2 downto 0);   
         
         a_i: in std_logic_vector(2 downto 0);
         b_i: in std_logic_vector(2 downto 0);
         c_i: in std_logic_vector(2 downto 0);
         d_i: in std_logic_vector(2 downto 0)
        
        
    );
end entity Multiplexer;


------------------------------------------------------------
-- Architecture body for 4-bit binary comparator
------------------------------------------------------------
architecture Behavioral of Multiplexer is
begin


with sel_i select

    f_o <= a_i when "00",  -- If sel_i = "000" then f_o = a_i
           b_i when "01",
           c_i when "10",
           d_i when "11"; -- All other combinations

  
  
end architecture Behavioral;
