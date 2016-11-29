library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

package header is

	type tail_coords_t is array (0 to 60) of std_logic_vector(9 downto 0);
	type map_t is array(0 to 20 ) of INTEGER;
	  
	  constant lvl_1 : map_t := 
  	  (   2, 
	    120, 250, 380, 250, -1, -1, -1, -1, -1, -1, 
	     15,  125,  15,  125, -1, -1, -1, -1, -1, -1  );
		  
	  constant lvl_2 : map_t := 
      	  (   4, 
     	    120, 250, 380, 250, 250, 40, 250, 400, -1, -1, 
	     15,  125,  15,  125, 75, 15, 75, 15, -1, -1  );

	  constant lvl_3 : map_t := 
      	  (   4, 
	     80, 250, 200, 250, 320, 250, 440, 250, -1, -1, 
	     15,  125,  15,  125, 15, 125, 15, 125, -1, -1 );

end header;
