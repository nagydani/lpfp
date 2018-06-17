; Reciprocal value
; In: HL denominator
; Out: HL reciprocal value
; Pollutes: AF
FREC:	LD	A,H
	XOR	$7F
	LD	H,DIVTAB/$100
	LD	L,(HL)
	LD	H,A
	LD	A,L
	OR	L
	RET	NZ	; not a power of 2
	LD	A,H
	AND	$80
	SET	7,H
	INC	H
	JR	Z,FRECH	; overflow
	XOR	$80
	XOR	H
	LD	H,A
	RET
FRECH:	OR	$7F
	LD	H,A
	LD	L,$FF
	RET

; Floating-point division
; In: BC numerator, HL denominator
; Out: HL fraction
; Pollutes: AF,AF',BC,DE
FDIV:	CALL	FREC
	EX	DE,HL
	; continues with FMUL

; Floating-point multiplication
; In: DE, BC multiplicands
; Out: HL product
; Pollutes: AF,AF',BC,DE
FMUL:	LD	A,B
	XOR	C
	AND	$80
	PUSH	AF
	RES	7,B
	RES	7,D
	CALL	FMULP
	POP	AF
	OR	H
	LD	H,A
	RET

; Floating-point multiplication of positive numbers
; In: DE, BC multiplicands
; Out: HL product
; Pollutes: AF,AF',BC,DE
FMULP:	LD	A,D
	ADD	B
	CP	$C0
	JR	NC,FINFTY	; overflow
	SUB	$40
	JR	C,FZERO		; underflow
	LD	H,A
	LD	A,E
	ADD	C
	LD	L,A
	PUSH	HL
	LD	B,E
	JR	NC,FMULN
	CALL	MUL8
	RL	L
	LD	A,H
	ADC	A,0		; rounding
	POP	HL
	ADD	L
	RRA
	ADC	A,0
	LD	L,A
	INC	H
	RET
FMULN:	CALL	MUL8
	RL	L
	LD	A,H
	ADC	A,0
	POP	HL
	ADD	L
	LD	L,A
	RET	NC
	SRA	L
	JR	NC,FMULL
	INC	L		; rounding
FMULL:	INC	H
	RET
FZERO:	LD	HL,MINF		; positive epsilon
	RET
