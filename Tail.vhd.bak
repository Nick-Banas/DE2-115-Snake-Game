library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.header.all;

entity Tail is
   Port ( Reset : in std_logic;
          frame_clk : in std_logic;
	  BallX : in std_logic_vector(9 downto 0);
          BallY: in std_logic_vector(9 downto 0);
	  BallX_prev : in std_logic_vector(9 downto 0);
          BallY_prev : in std_logic_vector(9 downto 0);
          BallS : in std_logic_vector(9 downto 0);
	  size : in integer;
	  tail_coords_x : out tail_coords_t;
	  tail_coords_y : out tail_coords_t );
end Tail;

architecture Behavioral of Tail is

	signal tail_coords_x_h : tail_coords_t; 
	signal tail_coords_y_h : tail_coords_t; 
	signal tail_coords_temp_x : tail_coords_t;
	signal tail_coords_temp_y : tail_coords_t;
	signal counter : std_logic_vector(1 downto 0);

begin

	handle_tail : process(Reset, frame_clk, size)
	begin
		if (Reset = '1' or size = 0) then
			for I in 1 to 60 loop
				tail_coords_x_h(I) <= conv_std_logic_vector(999, 10);
				tail_coords_y_h(I) <= conv_std_logic_vector(999, 10);
			end loop;
			counter <= "00";
			
		elsif(rising_edge(frame_clk) and Reset = '0') then
		
			counter <= counter + '1';
			
			if (counter = "11") then
				if (size = 0) then
					for I in 1 to 60 loop
						tail_coords_x_h(I) <= conv_std_logic_vector(999, 10);
						tail_coords_y_h(I) <= conv_std_logic_vector(999, 10);
					end loop;
				else
					for I in 1 to 60 loop
						exit when I > size;
						tail_coords_temp_x <= tail_coords_x_h;
						tail_coords_temp_y <= tail_coords_y_h;
				
						tail_coords_x_h(I) <= tail_coords_temp_x(I-1);
						tail_coords_y_h(I) <= tail_coords_temp_y(I-1);
					end loop;
					tail_coords_x_h(0) <= BallX_prev;
					tail_coords_y_h(0) <= BallY_prev;
			 	end if;
			end if;
		end if;
		
	end process handle_tail;
	
	tail_coords_x <= tail_coords_x_h;
	tail_coords_y <= tail_coords_y_h;

end Behavioral;
