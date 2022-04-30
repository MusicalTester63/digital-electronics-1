library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


-- deklarace vstupů a výstupů

entity translator is
    port(
        
        data_i	: in  std_logic_vector(5 downto 0);
		
      	data_o   	: out std_logic_vector(5 downto 0); 
      	length_o	: out std_logic_vector(5 downto 0)  
    
	);
end entity translator;

architecture Behavioral of translator is

    begin
	
	
	--DOT =1, DASH =0
	
		data_o	<=	"100000" when (data_i = "000000") else --A
					"011100" when (data_i = "000001") else --B
					"010100" when (data_i = "000010") else --C
					"011000" when (data_i = "000011") else --D
					"100000" when (data_i = "000100") else --E
					"110100" when (data_i = "000101") else --F
					"001000" when (data_i = "000110") else --G
					"111100" when (data_i = "000111") else --H
					"110000" when (data_i = "001000") else --I
					"100000" when (data_i = "001001") else --J
					"010000" when (data_i = "001010") else --K
					"101100" when (data_i = "001011") else --L
					"000000" when (data_i = "001100") else --M
					"010000" when (data_i = "001101") else --N
					"000000" when (data_i = "001110") else --O
					"100100" when (data_i = "001111") else --P
					"001000" when (data_i = "010000") else --Q
					"101000" when (data_i = "010001") else --R
					"111000" when (data_i = "010010") else --S
					"000000" when (data_i = "010011") else --T
					"110000" when (data_i = "010100") else --U
					"111000" when (data_i = "010101") else --V
					"100000" when (data_i = "010110") else --W
					"011000" when (data_i = "010111") else --X
					"010000" when (data_i = "011000") else --Y
					"001100" when (data_i = "011001") else --Z
					"000000" when (data_i = "011010") else --0
					"100000" when (data_i = "011011") else --1
					"110000" when (data_i = "011100") else --2
					"111000" when (data_i = "011101") else --3
					"111100" when (data_i = "011110") else --4
					"111110" when (data_i = "011111") else --5
					"011110" when (data_i = "100000") else --6
					"001110" when (data_i = "100001") else --7
					"000110" when (data_i = "100010") else --8
					"000010" when (data_i = "100011") else --9
					"100101" when (data_i = "100100") else --@
					"000000";
    
            length_o <= "110000" when (data_i = "000000") else --A
                       "111100" when (data_i = "000001") else --B
                       "111100" when (data_i = "000010") else --C
                       "111000" when (data_i = "000011") else --D
                       "100000" when (data_i = "000100") else --E
                       "111100" when (data_i = "000101") else --F
                       "111000" when (data_i = "000110") else --G
                       "111100" when (data_i = "000111") else --H
                       "110000" when (data_i = "001000") else --I
                       "111100" when (data_i = "001001") else --J
                       "111000" when (data_i = "001010") else --K
                       "111100" when (data_i = "001011") else --L
                       "110000" when (data_i = "001100") else --M
                       "110000" when (data_i = "001101") else --N
                       "111000" when (data_i = "001110") else --O
                       "111100" when (data_i = "001111") else --P
                       "111100" when (data_i = "010000") else --Q
                       "111000" when (data_i = "010001") else --R
                       "111000" when (data_i = "010010") else --S
                       "100000" when (data_i = "010011") else --T
                       "111000" when (data_i = "010100") else --U
                       "111100" when (data_i = "010101") else --V
                       "111000" when (data_i = "010110") else --W
                       "111100" when (data_i = "010111") else --X
                       "111100" when (data_i = "011000") else --Y
                       "111100" when (data_i = "011001") else --Z
                       "111110" when (data_i = "011010") else --0
                       "111110" when (data_i = "011011") else --1
                       "111110" when (data_i = "011100") else --2
                       "111110" when (data_i = "011101") else --3
                       "111110" when (data_i = "011110") else --4
                       "111110" when (data_i = "011111") else --5
                       "111110" when (data_i = "100000") else --6
                       "111110" when (data_i = "100001") else --7
                       "111110" when (data_i = "100010") else --8
                       "111110" when (data_i = "100011") else --9
                       "111111" when (data_i = "100100") else --@
					   "000000";



end architecture Behavioral;


