library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;
use work.header.all;

entity Main is
    Port ( Clk : in std_logic;
			direction : in std_logic_vector(3 downto 0);
			Reset : in std_logic;
			  Speed : in std_logic;
			size_LED : out std_logic_vector(7 downto 0);
			level_LED : out std_logic_vector (3 downto 0);
           Red   : out std_logic_vector(7 downto 0);
           Green : out std_logic_vector(7 downto 0);
           Blue  : out std_logic_vector(7 downto 0);
           VGA_clk : out std_logic; 
           sync : out std_logic;
           blank : out std_logic;
           vs : out std_logic;
           hs : out std_logic );
end Main;

architecture Behavioral of Main is

component ball is
    Port ( Reset : in std_logic;
	   direction : in std_logic_vector(3 downto 0);
           move_clk : in std_logic;
	   BallX_prev : out std_logic_vector(9 downto 0);
           BallY_prev : out std_logic_vector(9 downto 0);
           BallX : out std_logic_vector(9 downto 0);
           BallY : out std_logic_vector(9 downto 0);
           BallS : out std_logic_vector(9 downto 0);
	   tail_coords_x : in tail_coords_t;
	   tail_coords_y : in tail_coords_t;
	   collision : out std_logic;
	   size : in integer;
	   level : in integer;
	   level_up : in std_logic );
end component;

component Food is
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
end component;


component Tail is
   Port ( Reset : in std_logic;
          move_clk : in std_logic;
	  BallX : in std_logic_vector(9 downto 0);
          BallY: in std_logic_vector(9 downto 0);
	  BallX_prev : in std_logic_vector(9 downto 0);
          BallY_prev : in std_logic_vector(9 downto 0);
          BallS : in std_logic_vector(9 downto 0);
	  size : in integer;
	  tail_coords_x : out tail_coords_t;
	  tail_coords_y : out tail_coords_t );
end component;


component vga_controller is
    Port ( clk : in std_logic;
           reset : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           pixel_clk : out std_logic;
           blank : out std_logic;
           sync : out std_logic;
           DrawX : out std_logic_vector(9 downto 0);
           DrawY : out std_logic_vector(9 downto 0));
end component;

component Color_Mapper is
   Port ( BallX : in std_logic_vector(9 downto 0);
          BallY : in std_logic_vector(9 downto 0);
	  FoodX : in std_logic_vector(9 downto 0);
          FoodY : in std_logic_vector(9 downto 0);
          direction : in std_logic_vector(3 downto 0);
          DrawX : in std_logic_vector(9 downto 0); 
          DrawY : in std_logic_vector(9 downto 0);
          Ball_size : in std_logic_vector(9 downto 0);
	  Food_size : in std_logic_vector(9 downto 0);
	  tail_coords_x : in tail_coords_t;
	  tail_coords_y : in tail_coords_t;
	  size : in integer;
          Red   : out std_logic_vector(7 downto 0);
          Green : out std_logic_vector(7 downto 0);
          Blue  : out std_logic_vector(7 downto 0);
  	  level : in integer );
end component;


signal sizeSig : integer;
signal levelSig : integer;
signal level_upSig : std_logic;
signal Reset_h, vsSig : std_logic;
signal DrawXSig, DrawYSig, BallXSig, BallYSig, BallSSig : std_logic_vector(9 downto 0);
signal BallX_prevSig, BallY_prevSig : std_logic_vector(9 downto 0);
signal FoodXSig, FoodYSig, FoodSSig : std_logic_vector(9 downto 0);
signal tail_coords_x_Sig : tail_coords_t; 
signal tail_coords_y_Sig : tail_coords_t; 
signal collisionSig : std_logic;
signal move_clk : std_logic;
signal Clk_div : std_logic_vector(19 downto 0);

begin

Reset_h <= not Reset; -- The push buttons are active low
size_LED <= conv_std_LOGIC_VECTOR(sizeSig, 8); --output to the 7-seg decoders
level_LED <= conv_std_LOGIC_VECTOR(levelSig, 4); --output to the 7-seg decoders
vs <= vsSig; -- Used to pass vertical sync as an "ad hoc" 60 Hz clock signal to food

--Vga timing and resoultion
vgaSync_instance : vga_controller
	Port map(	clk => clk,
				reset => Reset_h,
				hs => hs,
				vs => vsSig,
				pixel_clk => VGA_clk,
				blank => blank,
				sync => sync,
				DrawX => DrawXSig,
				DrawY => DrawYSig);

--Handles shake head position, direction, and colision detection.				
ball_instance : ball
	Port map(	Reset => Reset_h,
				direction => direction,
				move_clk => move_clk, 
				BallX => BallXSig, 
				BallY => BallYSig,
				BallX_prev => BallX_prevSig, 
				BallY_prev => BallY_prevSig,
				BallS => BallSSig,
				collision => collisionSig,
				tail_coords_x => tail_coords_x_Sig,
				tail_coords_y => tail_coords_y_Sig,
				size => sizeSig,
				level => levelSig,
				level_up => level_upSig );

--Handles food generation, level up, and snake length				
Food_instance : food
	Port map(	 Reset => Reset_h,
				 frame_clk => vsSig,
				 BallX => BallXSig,  
				 BallY => BallYSig,
				 BallS => BallSSig,
				 FoodX => FoodXSig,
				 FoodY => FoodYSig,
				 FoodS => FoodSSig,
				 size => sizeSig,
				 level_up => level_upSig,
				 level => levelSig,
				 collision => collisionSig );
			 
--Handles tail position
Tail_instance : tail
	Port map(	Reset => Reset_h,
				move_clk => move_clk,
				BallX => BallXSig,  
				BallY => BallYSig,
				BallS => BallSSig,
				BallX_prev => BallX_prevSig,
				BallY_prev => BallY_prevSig,
				size => sizeSig,
				tail_coords_x => tail_coords_x_Sig,
				tail_coords_y => tail_coords_y_Sig );

--outputs color based off of snake position and vga draw postion
Color_instance : Color_Mapper
	Port Map( 	BallX => BallXSig,
				BallY => BallYSig,
				 FoodX => FoodXSig,
				 FoodY => FoodYSig,
				 direction => direction,
				 DrawX => DrawXSig,
				 DrawY => DrawYSig,
				 Ball_size => BallSSig,
				 Food_size => FoodSSig,
				 size => sizeSig,
				 Red => Red,
				 Green => Green,
				 Blue => Blue,
				 tail_coords_x => tail_coords_x_Sig,
				 tail_coords_y => tail_coords_y_Sig,
				 level => levelSig);

--clock divider for snake movement (determines speed)
process(Clk)
begin
	if(rising_edge(Clk))then
		if(clk_div<x"7A120")  then  --clock low (500k)	 
			move_clk<='0';
		elsif(clk_div>=x"7A120" and clk_div<=x"F4240")  then  --clock high (500k-1M) 
			move_clk<='1';
		else   --reset clock div
			clk_div<="00000000000000000000";
		end if;
		--speed selector
		if (speed = '1')	then
			clk_div <= clk_div + 1; --slow speed
		else
			clk_div <= clk_div + 3; --fast speed
		end if;
	end if;
end process;

end Behavioral;      
