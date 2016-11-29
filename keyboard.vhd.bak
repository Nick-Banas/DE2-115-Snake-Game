library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keyboardVhdl is
	Port (	CLK, RST, ps2Data, ps2Clk, NewKeyAck: in std_logic;
		keyCode : out std_logic_vector(7 downto 0);
		newKeyOut : out std_logic );
end keyboardVhdl; 

architecture Behavioral of keyboardVhdl is
	
	signal clkDiv : std_logic_vector (12 downto 0);
	signal pclk : std_logic;
	signal DFF1, DFF2 : std_logic;
	signal shiftRegSig1: std_logic_vector(10 downto 0);
	signal shiftRegSig2: std_logic_vector(10 downto 1);
	signal WaitReg: std_logic_vector (7 downto 0);
	signal enable : std_logic;
	signal newKey, acceptNewKey : std_logic;
	

	begin
	--Divide the master clock down to a lower frequency--
	CLKDivider: Process (CLK)
	begin
		if (rising_edge(CLK)) then 
			clkDiv <= clkDiv + 1; 
		end if;	
	end Process;

	pclk <= clkDiv(9);


	Process (pclk, RST, ps2clk, CLK)
	begin
		if(RST = '1') then
			DFF1 <= '0'; 
			DFF2 <= '0';
		else												
			if (rising_edge(pclk)) then
				DFF1 <= ps2clk;
			end if;
			
			if (rising_edge(CLK)) then
			  DFF2 <= DFF1;
			end if;
		end if;
	end process;
	
	Process (DFF1, DFF2)
	begin
		if (DFF1 = '0' and DFF2 ='1') then
			enable <= '1';
		else
			enable <= '0';
		end if;
	end process;

	--Shift Registers used to clock in scan codes from PS2--
	Process(pclk, enable, ps2Data, RST, CLK)
	begin																					  
		if (RST = '1') then
			ShiftRegSig1 <= "00000000001";
			ShiftRegSig2 <= "1111111111";
		else
			if (rising_edge(CLK) and enable='1') then
				ShiftRegSig1(10 downto 0) <= ps2Data & ShiftRegSig1(10 downto 1);
				ShiftRegSig2(10 downto 1) <= ShiftRegSig1(0) & ShiftRegSig2(10 downto 2);
			end if;
		end if;
	end process;
	
	--Wait Register
	process(ShiftRegSig1, ShiftRegSig2, RST, enable, CLK, WaitReg, newKey)
	begin
		if(RST = '1')then
			WaitReg <= x"00";
		else
			if(rising_edge(CLK) and ((WaitReg = ShiftRegSig2(8 downto 1)) or (ShiftRegSig2(8 downto 1) = x"F0")))then 
				WaitReg <= ShiftRegSig1(8 downto 1);
		
				if(ShiftRegSig2(8 downto 1) /= x"F0" and NewKeyAck /= '1' and acceptNewKey = '1') then		-- Last code read was not x"F0"
					keyCode <= ShiftRegSig1(8 downto 1); -- Capture makecode
					newKey <= '1';
					acceptNewKey <= '0';
				elsif (ShiftRegSig2(8 downto 1) = x"F0") then -- Last code read was x"F0"
					keyCode <= x"00"; -- breakcode is not captured to avoid implementation of handshaking
					newKey <= '0';
					acceptNewKey <= '1';
				elsif (newKeyAck = '1') then
					keyCode <= x"00";
					newKey <= '0';	
				end if;
			end if;				
		end if;
	end Process;

	newKeyOut <= newKey;

end Behavioral;
