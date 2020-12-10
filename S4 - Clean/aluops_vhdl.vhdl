library ieee;
use ieee.std_logic_1164.all;

PACKAGE aluops IS

	CONSTANT ALUNOP : STD_LOGIC_VECTOR (2 DOWNTO 0) := "000";
	CONSTANT SUBT : STD_LOGIC_VECTOR (2 DOWNTO 0) := "001";
	CONSTANT ADD : STD_LOGIC_VECTOR (2 DOWNTO 0) := "010";
	CONSTANT SHL : STD_LOGIC_VECTOR (2 DOWNTO 0) := "011";
	CONSTANT SHR : STD_LOGIC_VECTOR (2 DOWNTO 0) := "100";
	CONSTANT PASSA : STD_LOGIC_VECTOR (2 DOWNTO 0) := "101";
	CONSTANT CMP : STD_LOGIC_VECTOR (2 DOWNTO 0) := "110";

END PACKAGE;