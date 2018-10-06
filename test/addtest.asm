; Iterate through all values of HL >= DE and check FADDP
	ORG 	$C000
	DI
	EXX
	PUSH	HL
	LD	HL,0
	LD	E,L
	LD	D,H
LOOP:	PUSH	HL
	PUSH	DE
	CALL	FADDP
	LD	C,L
	LD	B,H
	POP	DE
	POP	HL
	PUSH	HL
	PUSH	BC
	PUSH	DE
	EX	DE,HL
	CALL	STKFP
	POP	DE
	PUSH	DE
	CALL	STKFP
	POP	DE
	POP	BC
	PUSH	DE
	PUSH	BC
	RST	$28
	DEFB	$0F,$38
	CALL	FPTODE
	EX	DE,HL
	POP	BC
	LD	A,H
	CP	B
	JR	NZ,MISMATCH
	LD	A,L
	CP	C
	JR	NZ,MISMATCH
	RST	$28
	DEFB	$02,$38
	POP	DE
	POP	HL
	INC	L
	JR	NZ,LOOP
	INC	H
	BIT	7,H
	JR	NZ,LOOP
	LD	L,E
	LD	H,D
	INC	HL
	INC	E
	JR	NZ,LOOP
	INC	D
	JR	NZ,LOOP
	POP	HL
	EXX
	LD	BC,0
	EI
	RET
MISMATCH:
	POP	DE
	POP	HL
	LD	C,L
	LD	B,H
	EXX
	POP	HL
	EXX
	EI
	RET

	INCLUDE "../hpfp.asm"

; floating point constants
MINF:	EQU	$0000		; Positive epsilon, 2^-64 			5.421e-20
MAXF:	EQU	$7FFF		; Maximal floating point number 2^64-2^55	1.841e+19
ONEF:	EQU	$4000		; One						1.000e+00
ROOT2F:	EQU	$406A		; Square root of 2				1.414e+00
F7F:	EQU	$46FC		; $7F i.e. 127					1.270e+02

; Subroutines
	INCLUDE "../fdivmul.asm"
	INCLUDE "../faddsub.asm"
	INCLUDE "../mul8bit.asm"
; Lookup tables
	INCLUDE "../addtab.asm"
	INCLUDE	"../subtab.asm"
	INCLUDE	"../multab.asm"
	INCLUDE	"../divtab.asm"
