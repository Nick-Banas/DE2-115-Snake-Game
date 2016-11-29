library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.header.all;

entity ball is
   Port ( Reset : in std_logic;
	  direction : in std_logic_vector(3 downto 0);
          frame_clk : in std_logic;
	  BallX_prev : out std_logic_vector(9 downto 0);
          BallY_prev : out std_logic_vector(9 downto 0);
          BallX : out std_logic_vector(9 downto 0);
          BallY : out std_logic_vector(9 downto 0);
          BallS : out std_logic_vector(9 downto 0);
	  collision : out std_logic;
    	  tail_coords_x : in tail_coords_t;
	  tail_coords_y : in tail_coords_t;
	  level : in integer;
	  level_up : in std_logic;
   	  size : in integer );
end ball;

architecture Behavioral of ball is

signal Ball_X_pos, Ball_X_motion, Ball_Y_pos, Ball_Y_motion : std_logic_vector(9 downto 0);
signal Ball_X_pos_prev, Ball_Y_pos_prev : std_logic_vector(9 downto 0);
signal Ball_Size : std_logic_vector(9 downto 0);

constant Ball_X_Center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(280, 10);  --Center position on the X axis
constant Ball_Y_Center : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(240, 10);  --Center position on the Y axis

constant Ball_X_Min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);  --Leftmost point on the X axis
constant Ball_X_Max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(639, 10);  --Rightmost point on the X axis
constant Ball_Y_Min    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(0, 10);   --Topmost point on the Y axis
constant Ball_Y_Max    : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(479, 10);  --Bottommost point on the Y axis
                              
constant Ball_X_Step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(2, 10);  --Step size on the X axis
constant Ball_Y_Step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(2, 10);  --Step size on the Y axis

signal collision_h : std_logic;

begin
  Ball_Size <= CONV_STD_LOGIC_VECTOR(4, 10); 
  Move_Ball: process(Reset, frame_clk, Ball_Size, direction)
  begin
  
    -- asynchronous reset
    if (Reset = '1' or collision_h = '1') then   
    	Ball_Y_Motion <= "0000000000";
    	Ball_X_Motion <= "0000000000";
    	Ball_Y_Pos <= Ball_Y_Center;
    	Ball_X_pos <= Ball_X_Center;
	collision_h <= '0';
		

    elsif(rising_edge(frame_clk)) then
	 
		if (level_up = '1') then
		      Ball_Y_Motion <= "0000000000";
		      Ball_X_Motion <= "0000000000";
		      Ball_Y_Pos <= Ball_Y_Center;
		      Ball_X_pos <= Ball_X_Center;
		else
	 
		-- collisions
			-- Snake is at the bottom edge
      			if (Ball_Y_Pos + Ball_Size >= conv_STD_LOGIC_VECTOR(478,10)) then 
				collision_h <= '1';
			-- Snake is at the top edge
			elsif (Ball_Y_Pos - Ball_Size <= conv_STD_LOGIC_VECTOR(1,10)) then  
				collision_h <= '1';
			-- Snake is at the right edge
      			elsif (Ball_X_Pos + Ball_Size >= conv_STD_LOGIC_VECTOR(500,10)) then 
				collision_h <= '1';
			 -- Snake is at the left edge
      			elsif (Ball_X_Pos - Ball_Size <= conv_STD_LOGIC_VECTOR(1,10)) then 
				collision_h <= '1';
			else 
				for I in 1 to 60 loop
				exit when I > size or collision_h = '1';
					-- Snake collided with self 
					if ( (Ball_X_Pos >= tail_coords_x(I) - Ball_size) AND
					     (Ball_X_Pos <= tail_coords_x(I) + Ball_size) AND
					     (Ball_Y_Pos >= tail_coords_y(I) - Ball_size) AND
					     (Ball_Y_Pos <= tail_coords_y(I) + Ball_size) ) then
					     
						collision_h <= '1';
					end if;
				end loop;
			
				if (level = 1) then
					-- collided with level 1 barrier
					if ( ((Ball_X_Pos >= lvl_1(1) - lvl_1(11)) AND
					      (Ball_X_Pos <= lvl_1(1) + lvl_1(11)) AND
					      (Ball_Y_Pos >= lvl_1(2) - lvl_1(12)) AND
					      (Ball_Y_Pos <= lvl_1(2) + lvl_1(12))) 
								OR
					     ((Ball_X_Pos >= lvl_1(3) - lvl_1(13)) AND
					      (Ball_X_Pos <= lvl_1(3) + lvl_1(13)) AND
					      (Ball_Y_Pos >= lvl_1(4) - lvl_1(14)) AND
					      (Ball_Y_Pos <= lvl_1(4) + lvl_1(14))) ) then
						
						collision_h <= '1';
					end if;
				
				elsif (level = 2) then
					-- collided with level 2 barrier
					if ( ((Ball_X_Pos >= lvl_2(1) - lvl_2(11)) AND
					      (Ball_X_Pos <= lvl_2(1) + lvl_2(11)) AND
					      (Ball_Y_Pos >= lvl_2(2) - lvl_2(12)) AND
					      (Ball_Y_Pos <= lvl_2(2) + lvl_2(12)))
								OR
					     ((Ball_X_Pos >= lvl_2(3) - lvl_2(13)) AND
					      (Ball_X_Pos <= lvl_2(3) + lvl_2(13)) AND
					      (Ball_Y_Pos >= lvl_2(4) - lvl_2(14)) AND
					      (Ball_Y_Pos <= lvl_2(4) + lvl_2(14)))
								OR
					     ((Ball_X_Pos >= lvl_2(5) - lvl_2(15)) AND
					      (Ball_X_Pos <= lvl_2(5) + lvl_2(15)) AND
					      (Ball_Y_Pos >= lvl_2(6) - lvl_2(16)) AND
					      (Ball_Y_Pos <= lvl_2(6) + lvl_2(16)))
								OR
					     ((Ball_X_Pos >= lvl_2(7) - lvl_2(17)) AND
					      (Ball_Y_Pos <= lvl_2(7) + lvl_2(17)) AND
					      (Ball_Y_Pos >= lvl_2(8) - lvl_2(18)) AND
					      (Ball_Y_Pos <= lvl_2(8) + lvl_2(18))) ) then
								
						collision_h <= '1';
					end if;
				
				
				elsif (level = 3) then
					-- collided with level 3 barrier
					if ( ((Ball_X_Pos >= lvl_3(1) - lvl_3(11)) AND
				   	      (Ball_X_Pos <= lvl_3(1) + lvl_3(11)) AND
					      (Ball_Y_Pos >= lvl_3(2) - lvl_3(12)) AND
					      (Ball_Y_Pos <= lvl_3(2) + lvl_3(12)))
								OR
					     ((Ball_X_Pos >= lvl_3(3) - lvl_3(13)) AND
					      (Ball_X_Pos <= lvl_3(3) + lvl_3(13)) AND
					      (Ball_Y_Pos >= lvl_3(4) - lvl_3(14)) AND
					      (Ball_Y_Pos <= lvl_3(4) + lvl_3(14)))
								OR
					     ((Ball_X_Pos >= lvl_3(5) - lvl_3(15)) AND
					      (Ball_X_Pos <= lvl_3(5) + lvl_3(15)) AND
					      (Ball_Y_Pos >= lvl_3(6) - lvl_3(16)) AND
					      (Ball_Y_Pos <= lvl_3(6) + lvl_3(16)))
								OR
					     ((Ball_X_Pos >= lvl_3(7) - lvl_3(17)) AND
					      (Ball_Y_Pos <= lvl_3(7) + lvl_3(17)) AND
					      (Ball_Y_Pos >= lvl_3(8) - lvl_3(18)) AND
					      (Ball_Y_Pos <= lvl_3(8) + lvl_3(18))) ) then
					      
						collision_h <= '1';
					end if;	
				end if;
				
			if (collision_h <= '0') then
				-- left
				if( direction = "1000") then 
					Ball_X_Motion <= not(Ball_X_Step) + '1';
					Ball_Y_Motion <= "0000000000";
				-- down
				elsif(direction = "0100") then 
					Ball_X_Motion <= "0000000000";
					Ball_Y_Motion <= Ball_Y_Step;
				-- up
				elsif( direction = "0001") then
					Ball_Y_Motion <= not(Ball_Y_Step) + '1';
					Ball_X_Motion <= "0000000000";
				-- right
				elsif(direction = "0010") then 
					Ball_Y_Motion <= "0000000000";
					Ball_X_Motion <= Ball_X_Step; 
				-- keep current trajectory
				else
					Ball_X_Motion <= Ball_X_Motion; 
					Ball_Y_Motion <= Ball_Y_Motion;
				end if;
			end if;
		end if;

		-- update snake position 
		Ball_Y_pos_prev <= Ball_Y_pos;
		Ball_X_pos_prev <= Ball_X_pos;
      		Ball_Y_pos <= Ball_Y_pos + Ball_Y_Motion; 
      		Ball_X_pos <= Ball_X_pos + Ball_X_Motion;
			
		end if;
    end if;
  
   end process Move_Ball;

  BallX_prev <= Ball_X_Pos_prev;
  BallY_prev <= Ball_Y_Pos_prev;
  BallX <= Ball_X_Pos;
  BallY <= Ball_Y_Pos;
  BallS <= Ball_Size;
  collision <= collision_h;
 
end Behavioral;      
