

LowCount	EQU $4000	; Global variable definition
HighCount	EQU $4001
Result	EQU $7F90	; Global variable definition

		ORG $00
		LDAI $0000
		STAD Result
TOP		LDAI $000A
		STAD HighCount
OUTER	LDAI $FFFF
		STAD LowCount
INNER	LDAD LowCount
		DECA
		STAD LowCount
		PUSHA
		CLRA
		SUBA
		BEQ #(INOUT)
		BRA #(INNER)
INOUT	LDAD HighCount
		DECA
		STAD HighCount
		PUSHA
		CLRA
		SUBA
		BEQ #(OUTOUT)
		BRA #(OUTER)
OUTOUT	LDAD Result
		INCA
		NOP
		NOP
		NOP
		STAD Result
		DECA
		BRA #(TOP)
		
