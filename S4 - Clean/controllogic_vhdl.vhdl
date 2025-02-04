library ieee;
use ieee.std_logic_1164.all;
USE WORK.opcodes.all;
use work.aluops.all;

ENTITY ControlLogic_vhdl IS
PORT (
   CLK,RESET, N,Z: IN STD_LOGIC;
	IR : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	
   RD, WR, LD_MAR, OE_MAR : OUT STD_LOGIC;
   OE_SP, LD_SP, PD_SP, PI_SP : OUT STD_LOGIC;
   OE_FP, LD_FP, OE_XP, LD_XP	: OUT STD_LOGIC;
   INC_XP, DEC_XP					: OUT STD_LOGIC;
   LD_PC, CNT_PC, OE_PC			: OUT STD_LOGIC;
   LD_MDR, OE_MDR, LD_IR, OE_IRL		: OUT STD_LOGIC;
   LD_A, CLR_A, DEC_A, INC_A	: OUT STD_LOGIC;
	OE_AA, OE_AD	: OUT STD_LOGIC;
   ALU_OP : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
);
END ControlLogic_vhdl;

ARCHITECTURE RTL of ControlLogic_vhdl IS
TYPE State_type IS 
(
	Zero,
	Fetch,
	Decode,
	ADDA_1
);
	SIGNAL CLUState : State_type;
BEGIN
	-- The next state logic is in the PROCESS block
	PROCESS (CLK,RESET)
	BEGIN
		IF (RESET = '1') THEN
			CLUState <= Zero;
		
		ELSIF rising_edge(CLK) THEN
			CASE CLUState IS
				WHEN Zero =>
					CLUState <= Fetch;
				WHEN Fetch =>
					CLUState <= Decode;
				WHEN Decode =>
					CASE IR(15 downto 8) IS
						WHEN PUSHA =>
							CLUState <= Fetch;
						WHEN ADDA =>
							CLUState <= ADDA_1;
						WHEN LDAI =>
							CLUState <= Fetch;
						WHEN BEQ =>
							CLUState <= Fetch;
						WHEN OTHERS =>
							CLUState <= Fetch;
					END CASE;					
				WHEN ADDA_1 =>
					CLUState <= Fetch;
				
				WHEN OTHERS =>
					CLUState <= Fetch;
			END CASE;
		END IF;
	END PROCESS;
	
	-- Output process begins here
	PROCESS (CLUState, IR, N, Z)
	BEGIN
		-- Default values for the outputs are specified outside the CASE
		RD <= '0';
		WR <= '0';
		LD_MAR <= '0';
		OE_MAR <= '0';
		OE_SP <= '0';
		LD_SP <= '0';
		PD_SP <= '0';
		PI_SP <= '0';
		OE_FP <= '0';
		LD_FP <= '0';
		OE_XP <= '0';
		LD_XP <= '0';
		INC_XP <= '0';
		DEC_XP <= '0';
		LD_PC <= '0';
		CNT_PC <= '0';
		OE_PC <= '0';
		LD_MDR <= '0';
		OE_MDR <= '0';
		LD_IR <= '0';
		OE_IRL <= '0';
		LD_A <= '0';
		CLR_A <= '0';
		DEC_A <= '0';
		INC_A <= '0';
		OE_AA <= '0';
		OE_AD <= '0';
		ALU_OP <= ALUNOP;

		CASE CLUState IS
			WHEN Zero =>
			WHEN Fetch =>
				OE_PC <= '1';
				CNT_PC <= '1';
				RD <= '1';
				LD_IR <='1';
			WHEN DECODE =>
				CASE IR(15 downto 8) IS
					WHEN PUSHA =>
						OE_AD <= '1';
						PD_SP <= '1';
						WR <= '1';
					WHEN ADDA =>
						PI_SP <= '1';
						RD <= '1';
						LD_MDR <= '1';
					WHEN LDAI =>
						OE_PC <= '1';
						CNT_PC <= '1';
						RD <='1';
						LD_A <='1';
					WHEN BEQ =>
						OE_PC <= '1';
						OE_IRL <= '1';
						ALU_OP <= ADD;
						IF (Z='1') THEN
							LD_PC <= '1';
						END IF;
					WHEN OTHERS =>
				END CASE;
			WHEN ADDA_1 =>
				OE_MDR <='1';
				OE_AA <='1';
				ALU_OP <= ADD;
				LD_A <= '1';
			WHEN OTHERS =>
				LD_A <= '1';
		END CASE;
	END PROCESS;
END RTL;
