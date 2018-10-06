; Interfacing with the high-precision calculator in the ZX Spectrum ROM
FP_CALC:	EQU	$28
RSTK:		EQU	$3D	; No such thing needed on ZX81
END_CALC:	EQU	$38	; $34 for ZX81
STK_STORE:	EQU	$2AB6	; $12C3 for ZX81

; Store floating point number on the calculator stack
; Input: DE = number to stack
; Pollutes: AF, BC, DE, HL
STKFP:	LD	A,D
	ADD	A,A
	RL	E
	RRCA
	ADD	$41
	LD	BC,0
	LD	D,B
	RL	D
	JP	STK_STORE

; Retrieve floating point number from the calculator stack
; Output: DE = retrieved floating point number
; Pollutes: AF, BC, BC', DE', HL, HL'
FPTOHL:	RST	FP_CALC
	DEFB	RSTK		; Remove for ZX81
	DEFB	END_CALC
	LD	A,(HL)
	INC	HL
	LD	E,(HL)
	SUB	$41
	JR	C,UNDERF
	ADD	A,A
	JR	C,OVERF
	INC	HL
	LD	D,(HL)
	SLA	D
	RL	E
	RRA
	SLA	D	; only need CF
	LD	D,A
	RET	NC
	INC	E
	RET	NZ
	INC	D
	XOR	D
	ADD	A,A
	RET	NC
	DEC	D
	JR	OVERFE
UNDERF:	LD	A,$80
	AND	E
	LD	D,A
	LD	E,0
	RET
OVERF:	LD	A,$7F
	OR	E
	LD	D,A
OVERFE:	LD	E,$FF
	RET
