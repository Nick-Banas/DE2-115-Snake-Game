library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use work.header.all;


entity Food is
   Port ( Reset : in std_logic;
          frame_clk : in std_logic;
	  BallX : in std_logic_vector(9 downto 0);
          BallY : in std_logic_vector(9 downto 0);
          BallS : in std_logic_vector(9 downto 0);
          FoodX : out std_logic_vector(9 downto 0);
          FoodY : out std_logic_vector(9 downto 0);
          FoodS : out std_logic_vector(9 downto 0);
	  size : out integer;
	  collision : in std_logic;
	  level_up : out std_logic;
	  level : out integer );
end Food;

architecture Behavioral of Food is

signal new_food : std_logic;
signal size_h : integer range 0 to 20 := 0;

signal rand_x : std_logic_vector(9 downto 0);
signal rand_y : std_logic_vector(9 downto 0);

signal Food_X_pos, Food_Y_pos : std_logic_vector(9 downto 0);
signal Food_Size : std_logic_vector(9 downto 0);
constant Food_X_Center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(320, 10);  --Center position on the X axis
constant Food_Y_Center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);  --Center position on the Y axis
constant Food_X_Min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);  --Leftmost point on the X axis
constant Food_X_Max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(639, 10);  --Rightmost point on the X axis
constant Food_Y_Min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);   --Topmost point on the Y axis
constant Food_Y_Max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(479, 10);  --Bottommost point on the Y axis
                              
signal level_up_h : std_logic;
signal level_h : integer;
										
begin
    
    Food_Size <= CONV_STD_LOGIC_VECTOR(4, 10); 
	
    random_num_gen : process(frame_clk)
    	variable rand_temp : std_logic_vector(9 downto 0):=(9 => '1',others => '0');
	variable temp : std_logic := '0';
    begin
    	if (rising_edge(frame_clk)) then
		temp := rand_temp(9) xor rand_temp(8);
		rand_temp(9 downto 1) := rand_temp(8 downto 0);
		rand_temp(0) := temp;
	end if;
		rand_x <= rand_temp;
		rand_y <= conv_std_LOGIC_VECTOR(conv_integer(rand_x)*7, 10);
    end process random_num_gen;  
  

    parse_food : process(Reset, new_food, frame_clk, Food_Size, collision, rand_x, rand_y, Food_X_pos, Food_Y_pos)
    	variable temp_X : integer;
	variable temp_Y : integer;
	variable valid_location : std_logic;
    begin
    	if( (Reset = '1' or collision = '1') and level_up_h = '0') then
		new_food <= '1';
		size_h <= 0;
		level_h <= 1;
		
    	elsif(rising_edge(frame_clk)) then
		if (level_up_h = '1') then
			size_h <= 0;
			level_up_h <= '0';
	    	-- generate food location
		elsif (new_food = '1') then
			temp_X := ( conv_integer(rand_x) mod 460 ) + 20;
	 		temp_Y := (conv_integer(rand_y) mod 420 ) + 20;
	 		-- don't generate food on obstacles
			if (level_h = 1) then		
				if ( ((temp_X+3 >= conv_std_logic_vector(lvl_1(1) - lvl_1(11),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_1(1) + lvl_1(11),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_1(2) - lvl_1(12),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_1(2) + lvl_1(12),10)))) then
						Food_X_pos <= conv_std_logic_vector(50,10);
						Food_Y_pos <= conv_std_logic_vector(40,10);
				elsif ( (temp_X+3 >= conv_std_logic_vector(lvl_1(3) - lvl_1(13),10)) AND
					(temp_X-3 <= conv_std_logic_vector(lvl_1(3) + lvl_1(13),10)) AND
					(temp_Y+3 >= conv_std_logic_vector(lvl_1(4) - lvl_1(14),10)) AND
					(temp_Y-3 <= conv_std_logic_vector(lvl_1(4) + lvl_1(14),10))) THEn
						Food_X_pos <= conv_std_logic_vector(50,10);
						Food_Y_pos <= conv_std_logic_vector(40,10);
				else
					Food_X_pos <= conv_std_logic_vector(temp_X,10);
					Food_Y_pos <= conv_std_logic_vector(temp_Y,10);
				end if;
				
			elsif (level_h = 2) then
				if ( ((temp_X+3 >= conv_std_logic_vector(lvl_2(1) - lvl_2(11),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_2(1) + lvl_2(11),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_2(2) - lvl_2(12),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_2(2) + lvl_2(12),10)))
								OR
				     ((temp_X+3 >= conv_std_logic_vector(lvl_2(3) - lvl_2(13),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_2(3) + lvl_2(13),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_2(4) - lvl_2(14),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_2(4) + lvl_2(14),10)))
								OR
				     ((temp_X+3 >= conv_std_logic_vector(lvl_2(5) - lvl_2(15),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_2(5) + lvl_2(15),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_2(6) - lvl_2(16),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_2(6) + lvl_2(16),10)))
								OR
				     ((temp_X+3 >= conv_std_logic_vector(lvl_2(7) - lvl_2(17),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_2(7) + lvl_2(17),10)) AND
			     	      (temp_Y+3 >= conv_std_logic_vector(lvl_2(8) - lvl_2(18),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_2(8) + lvl_2(18),10))) )						THEn
						Food_X_pos <= conv_std_logic_vector(50,10);
						Food_Y_pos <= conv_std_logic_vector(40,10);
				else
					Food_X_pos <= conv_std_logic_vector(temp_X,10);
					Food_Y_pos <= conv_std_logic_vector(temp_Y,10);
				end if;	
					
			elsif (level_h = 3) then
				if ( ((temp_X+3 >= conv_std_logic_vector(lvl_3(1) - lvl_3(11),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_3(1) + lvl_3(11),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_3(2) - lvl_3(12),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_3(2) + lvl_3(12),10)))
								OR
				     ((temp_X >= conv_std_logic_vector(lvl_3(3) - lvl_3(13),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_3(3) + lvl_3(13),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_3(4) - lvl_3(14),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_3(4) + lvl_3(14),10)))
								OR
			    	     ((temp_X+3 >= conv_std_logic_vector(lvl_3(5) - lvl_3(15),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_3(5) + lvl_3(15),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_3(6) - lvl_3(16),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_3(6) + lvl_3(16),10)))
								OR
				     ((temp_X+3 >= conv_std_logic_vector(lvl_3(7) - lvl_3(17),10)) AND
				      (temp_X-3 <= conv_std_logic_vector(lvl_3(7) + lvl_3(17),10)) AND
				      (temp_Y+3 >= conv_std_logic_vector(lvl_3(8) - lvl_3(18),10)) AND
				      (temp_Y-3 <= conv_std_logic_vector(lvl_3(8) + lvl_3(18),10))))						THEn
						Food_X_pos <= conv_std_logic_vector(50,10);
						Food_Y_pos <= conv_std_logic_vector(40,10);
				else
					Food_X_pos <= conv_std_logic_vector(temp_X,10);
					Food_Y_pos <= conv_std_logic_vector(temp_Y,10);
				end if;	
			end if;
			
			new_food <= '0';
		
		else
			if ( (BallX >= Food_X_pos - Food_size - 5) AND
			     (BallX <= Food_X_pos + Food_size + 5) AND
			     (BallY >= Food_Y_pos - Food_size - 5) AND
			     (BallY <= Food_Y_pos + Food_size + 5)) then 
				new_food <= '1';
					
				if (size_h = 9 and level_h < 3) then
					level_h <= level_h + 1;
					level_up_h <= '1';
				end if;
					size_h <= size_h + 1;

			else
				new_food <=  '0';
				size_h <= size_h;
			end if;
	 
    		end if;
    	end if;
    end process parse_food;

    FoodX <= Food_X_pos;
    FoodY <= Food_Y_pos;
    FoodS <= Food_Size;
    size <= size_h;
    level_up <= level_up_h;
    level <= level_h;
 
end Behavioral;      
