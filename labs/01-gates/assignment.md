# Lab 1: David Hamran
## Zmena test123456789

### De Morgan's laws

1. Equations of all three versions of logic function f(c,b,a):

   ![git](images/screen.jpg)
   ![git](images/screeen2.jpg)

2. Listing of VHDL architecture from design file (`design.vhd`) for all three functions. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

```vhdl
architecture dataflow of demorgan is
begin
  f_o  <= (not(b_i) and a_i) or (not(c_i) and not(b_i));    
  f_nand_o <= (a_i nand (b_i nand b_i)) nand ((b_i nand b_i) nand (c_i nand c_i));
  f_nor_o <= (a_i nor (c_i nor c_i))nor b_i;    
end architecture dataflow;
```

3. Complete table with logic functions' values:

| **c** | **b** |**a** | **f(c,b,a)** | **f_NAND(c,b,a)** | **f_NOR(c,b,a)** |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 | 1 | 1 |
| 0 | 0 | 1 | 1 | 1 | 1 |
| 0 | 1 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 | 1 | 1 |
| 1 | 1 | 0 | 0 | 0 | 0 |
| 1 | 1 | 1 | 0 | 0 | 0 |

### Distributive laws

1. Screenshot with simulated time waveforms. Always display all inputs and outputs (display the inputs at the top of the image, the outputs below them) at the appropriate time scale!

   ![git](images/distributive_law.jpg)


2. Link to your public EDA Playground example:

   https://www.edaplayground.com/x/GWxV
