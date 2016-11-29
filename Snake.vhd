-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Tue Nov 08 10:01:37 2016"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY Snake IS 
	PORT
	(
		CLK :  IN  STD_LOGIC;
		RST :  IN  STD_LOGIC;
		ps2Data :  IN  STD_LOGIC;
		ps2Clk :  IN  STD_LOGIC;
		Speed :  IN  STD_LOGIC;
		VGA_clk :  OUT  STD_LOGIC;
		sync :  OUT  STD_LOGIC;
		blank :  OUT  STD_LOGIC;
		vs :  OUT  STD_LOGIC;
		hs :  OUT  STD_LOGIC;
		newKeyOut :  OUT  STD_LOGIC;
		Blue :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		Green :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		Out0 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		Out1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		Out2 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		Red :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END Snake;

ARCHITECTURE bdf_type OF Snake IS 

COMPONENT mainbody
	PORT(Clk : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 Speed : IN STD_LOGIC;
		 direction : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 VGA_clk : OUT STD_LOGIC;
		 sync : OUT STD_LOGIC;
		 blank : OUT STD_LOGIC;
		 vs : OUT STD_LOGIC;
		 hs : OUT STD_LOGIC;
		 Blue : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 Green : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 level_LED : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Red : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 size_LED : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT hexdriver
	PORT(In0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Out0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT keycode
	PORT(current_code : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 direction : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT keyboardvhdl
	PORT(CLK : IN STD_LOGIC;
		 RST : IN STD_LOGIC;
		 ps2Data : IN STD_LOGIC;
		 ps2Clk : IN STD_LOGIC;
		 NewKeyAck : IN STD_LOGIC;
		 newKeyOut : OUT STD_LOGIC;
		 keyCode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	size_sig :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN 
SYNTHESIZED_WIRE_3 <= '0';



b2v_inst : mainbody
PORT MAP(Clk => CLK,
		 Reset => RST,
		 Speed => Speed,
		 direction => SYNTHESIZED_WIRE_0,
		 VGA_clk => VGA_clk,
		 sync => sync,
		 blank => blank,
		 vs => vs,
		 hs => hs,
		 Blue => Blue,
		 Green => Green,
		 level_LED => SYNTHESIZED_WIRE_4,
		 Red => Red,
		 size_LED => size_sig);


b2v_inst1 : hexdriver
PORT MAP(In0 => size_sig(3 DOWNTO 0),
		 Out0 => Out0);


b2v_inst2 : keycode
PORT MAP(current_code => SYNTHESIZED_WIRE_1,
		 direction => SYNTHESIZED_WIRE_0);


b2v_inst3 : keyboardvhdl
PORT MAP(CLK => CLK,
		 RST => SYNTHESIZED_WIRE_2,
		 ps2Data => ps2Data,
		 ps2Clk => ps2Clk,
		 NewKeyAck => SYNTHESIZED_WIRE_3,
		 newKeyOut => newKeyOut,
		 keyCode => SYNTHESIZED_WIRE_1);



SYNTHESIZED_WIRE_2 <= NOT(RST);



b2v_inst6 : hexdriver
PORT MAP(In0 => size_sig(7 DOWNTO 4),
		 Out0 => Out1);


b2v_inst7 : hexdriver
PORT MAP(In0 => SYNTHESIZED_WIRE_4,
		 Out0 => Out2);


END bdf_type;