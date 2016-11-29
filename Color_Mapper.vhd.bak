library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.header.all;


entity Color_Mapper is
   Port ( BallX : in std_logic_vector(9 downto 0);
          BallY : in std_logic_vector(9 downto 0);
	  FoodX : in std_logic_vector(9 downto 0);
          FoodY : in std_logic_vector(9 downto 0);
          DrawX : in std_logic_vector(9 downto 0); -- These are the beam inputs
          DrawY : in std_logic_vector(9 downto 0);
          Ball_size : in std_logic_vector(9 downto 0);
	  Food_size : in std_logic_vector(9 downto 0);
	  direction : in std_logic_vector(3 downto 0);
	  size : in integer;
	  tail_coords_x : in tail_coords_t;
	  tail_coords_y : in tail_coords_t;
          Red   : out std_logic_vector(9 downto 0);
          Green : out std_logic_vector(9 downto 0);
          Blue  : out std_logic_vector(9 downto 0);
	  level : in integer );
end Color_Mapper;

architecture Behavioral of Color_Mapper is

signal Ball_on : std_logic;
signal Food_on : std_logic;
signal Tail_on : std_logic;
signal Level_on : std_logic;
Signal Border_on : std_logic;

begin

    Border_on_proc : process (DrawX, DrawY)
    begin
	if ( (DrawX = conv_std_logic_vector(500, 10)) OR
	     (DrawX = conv_std_logic_Vector(1, 10)) OR
	     (DrawY = conv_std_logic_vector(1, 10)) OR
	     (DrawY = conv_std_logic_Vector(478, 10)) ) then 
	        Border_on <= '1';
	else
		Border_on <= '0';
	end if;
    end process Border_on_proc;
    

    Ball_on_proc : process (BallX, BallY, DrawX, DrawY, Ball_size)
    begin
	if ( (((DrawX - BallX) * (DrawX - BallX)) + 
	     ((DrawY - BallY) * (DrawY - BallY))) <= (Ball_Size*Ball_Size) ) then
        	Ball_on <= '1';
    	else
      		Ball_on <= '0';
    	end if;
    end process Ball_on_proc;


    Food_on_proc : process (FoodX, FoodY, DrawX, DrawY, Food_size)
    begin
	if ( (DrawX >= FoodX - Food_size) AND
	     (DrawX <= FoodX + Food_size) AND
	     (DrawY >= FoodY - Food_size) AND
	     (DrawY <= FoodY + Food_size) ) then 
	         Food_on <= '1';
	else
		 Food_on <= '0';
	end if;
    end process Food_on_proc;


    Body_on_proc : process(DrawX, DrawY, size)
    begin
	Tail_on <= '0';
	for I in 1 to 60 loop
	exit when Tail_on = '1';
		if ( (DrawX >= tail_coords_x(I) - Ball_size) AND
		     (DrawX <= tail_coords_x(I) + Ball_size) AND
		     (DrawY >= tail_coords_y(I) - Ball_size) AND
		     (DrawY <= tail_coords_y(I) + Ball_size) )  then 
			 Tail_on <= '1';
		end if;
	end loop;
    end process Body_on_proc;


    lvl_on_proc : process(DrawX, DrawY, level)
    begin
	if (level = 1) then
		if ( (DrawX >= conv_std_logic_vector(lvl_1(1) - lvl_1(11),10)) AND
		     (DrawX <= conv_std_logic_vector(lvl_1(1) + lvl_1(11),10)) AND
		     (DrawY >= conv_std_logic_vector(lvl_1(2) - lvl_1(12),10)) AND
		     (DrawY <= conv_std_logic_vector(lvl_1(2) + lvl_1(12),10)) )  then 
				Level_on <= '1';
		elsif ( (DrawX >= conv_std_logic_vector(lvl_1(3) - lvl_1(13),10)) AND
		        (DrawX <= conv_std_logic_vector(lvl_1(3) + lvl_1(13),10)) AND
		  	(DrawY >= conv_std_logic_vector(lvl_1(4) - lvl_1(14),10)) AND
		  	(DrawY <= conv_std_logic_vector(lvl_1(4) + lvl_1(14),10)) )  then 
				Level_on <= '1';
		else
				Level_on <= '0';
		end if;
				
	elsif (level = 2) then
		if ( (DrawX >= conv_std_logic_vector(lvl_2(1) - lvl_2(11),10)) AND
		     (DrawX <= conv_std_logic_vector(lvl_2(1) + lvl_2(11),10)) AND
		     (DrawY >= conv_std_logic_vector(lvl_2(2) - lvl_2(12),10)) AND
		     (DrawY <= conv_std_logic_vector(lvl_2(2) + lvl_2(12),10)) )  then 
				Level_on <= '1';
		elsif ( (DrawX >= conv_std_logic_vector(lvl_2(3) - lvl_2(13),10)) AND
		  	(DrawX <= conv_std_logic_vector(lvl_2(3) + lvl_2(13),10)) AND
		  	(DrawY >= conv_std_logic_vector(lvl_2(4) - lvl_2(14),10)) AND
		  	(DrawY <= conv_std_logic_vector(lvl_2(4) + lvl_2(14),10)) )  then 
				Level_on <= '1';
		elsif ( (DrawX >= conv_std_logic_vector(lvl_2(5) - lvl_2(15),10)) AND
		  	(DrawX <= conv_std_logic_vector(lvl_2(5) + lvl_2(15),10)) AND
		  	(DrawY >= conv_std_logic_vector(lvl_2(6) - lvl_2(16),10)) AND
		  	(DrawY <= conv_std_logic_vector(lvl_2(6) + lvl_2(16),10)) )  then 
				Level_on <= '1';
		elsif ( (DrawX >= conv_std_logic_vector(lvl_2(7) - lvl_2(17), 10)) AND
		  	(DrawX <= conv_std_logic_vector(lvl_2(7) + lvl_2(17),10)) AND
		  	(DrawY >= conv_std_logic_vector(lvl_2(8) - lvl_2(18),10)) AND
		  	(DrawY <= conv_std_logic_vector(lvl_2(8) + lvl_2(18),10)) )  then 
				Level_on <= '1';
		else
				Level_on <= '0';
		end if;
				
	elsif (level = 3) then
		if ( (DrawX >= conv_std_logic_vector(lvl_3(1) - lvl_3(11),10)) AND
		     (DrawX <= conv_std_logic_vector(lvl_3(1) + lvl_3(11),10)) AND
		     (DrawY >= conv_std_logic_vector(lvl_3(2) - lvl_3(12),10)) AND
		     (DrawY <= conv_std_logic_vector(lvl_3(2) + lvl_3(12),10)) )  then 
				Level_on <= '1';
		elsif ( (DrawX >= conv_std_logic_vector(lvl_3(3) - lvl_3(13),10)) AND
		  	(DrawX <= conv_std_logic_vector(lvl_3(3) + lvl_3(13),10)) AND
		  	(DrawY >= conv_std_logic_vector(lvl_3(4) - lvl_3(14),10)) AND
		  	(DrawY <= conv_std_logic_vector(lvl_3(4) + lvl_3(14),10)) )  then 
				Level_on <= '1';
		elsif ( (DrawX >= conv_std_logic_vector(lvl_3(5) - lvl_3(15),10)) AND
		  	(DrawX <= conv_std_logic_vector(lvl_3(5) + lvl_3(15),10)) AND
		  	(DrawY >= conv_std_logic_vector(lvl_3(6) - lvl_3(16),10)) AND
		  	(DrawY <= conv_std_logic_vector(lvl_3(6) + lvl_3(16),10)) )  then 
				Level_on <= '1';
		elsif ( (DrawX >= conv_std_logic_vector(lvl_3(7) - lvl_3(17), 10)) AND
		  	(DrawX <= conv_std_logic_vector(lvl_3(7) + lvl_3(17),10)) AND
		  	(DrawY >= conv_std_logic_vector(lvl_3(8) - lvl_3(18),10)) AND
		  	(DrawY <= conv_std_logic_vector(lvl_3(8) + lvl_3(18),10)) )  then 
				Level_on <= '1';
		else
				Level_on <= '0';
		end if;
				
	end if;
    end process lvl_on_proc;
  

  RGB_Display : process (Ball_on, DrawX, DrawY)
  begin
	if (Food_on = '1') then
      		Red <= "1111111111";
      		Green <= "0000000000";
      		Blue <= "0000000000";
      	elsif (Border_on = '1') then
	   	Red <= "1111111111";
      		Green <= "1111111111";
      		Blue <= "0000000000";
	 elsif (Ball_on = '1') then
	        Red <= "0000000000";
	        Green <= "1010101010";
	        Blue <= "0101010101";
	elsif (Tail_on = '1') then
	        Red <= "1111111111";
	        Green <= "1111111111";
	        Blue <= "1111111111";
	elsif (Level_on = '1') then
	        Red <= not BallX; 
	        Green <= BallY;
	        Blue <= BallX; 
	else          -- black background
	        Red   <= "0000000000";--DrawX(9 downto 0); 
	        Green <= "0000000000";--DrawX(9 downto 0);
	        Blue  <= "0000000000";--DrawX(9 downto 0);
    	end if;   
    end process RGB_Display;
  
end Behavioral;
