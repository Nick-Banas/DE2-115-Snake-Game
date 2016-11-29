library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keyCode is -- identifies the key code
		port( current_code:  in std_logic_vector(7 downto 0);
		      direction : out std_logic_vector(3 downto 0) );
end keyCode;

architecture keyCode_Behavioral of keyCode is

begin
 matchKey : process(current_code) is
	begin
		case current_code(7 downto 0) is
			when x"1D" => -- checks for W, x1D
				direction <= "0001";
				
			when x"1C" => -- checks for A, x1C
				direction <= "1000";
				
			when x"1B" => -- checks for S, x1B
				direction <= "0100";
				
			when x"23" => -- checks for D, x23
				direction <= "0010";
				
			when x"75" => -- checks for up, x75
				direction <= "0001";
				
			when x"6B" => -- checks for left, x6B
				direction <= "1000";
				
			when x"72" => -- checks for down, x72
				direction <= "0100";
				
			when x"74" => -- checks for right, x74
				direction <= "0010";						
		
			when others =>
				direction <= "0000";
			end case;
	end process;
end keyCode_Behavioral;
				
	
