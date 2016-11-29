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
			when "00011101" => -- checks for W, x1D
				direction <= "0001";
				
			when "00011100" => -- checks for A, x1C
				direction <= "1000";
				
			when "00011011" => -- checks for S, x1B
				direction <= "0100";
				
			when "00100011" => -- checks for D, x23
				direction <= "0010";
				
			when others =>
				direction <= "0000";
			end case;
	end process;
end keyCode_Behavioral;
				
	
