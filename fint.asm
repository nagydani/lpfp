; Round towards zero
; In: HL any floating-point number
; Out: HL same number rounded towards zero
; Pollutes: AF,B
FINT:	LD	A,H
	AND	$7F
	SUB	$40
	JR	C,FZERO	; Completely fractional
	SUB	8
	RET	NC	; Already integer
	AND	7
	JR	Z,FINT0
	LD	B,A
	LD	A,$FF
FINTL:	ADD	A,A
	DJNZ	FINTL
	AND	L
FINT0:	LD	L,A
	RET
FZERO:	LD	HL,MINF
	RET

; Fractional part, remainder after division by 1
; In: HL any floating-point number
; Out: HL fractional part, with sign intact
; Pollutes: AF,AF',BC,DE
FRAC:	PUSH	HL
	CALL	FINT
	EX	DE,HL
	POP	HL
	JR	FSUB

; Remainder after division
; In: BC dividend, HL modulus
; Out: HL remainder
; Pollutes: AF,AF',BC,DE
FMOD:	PUSH	BC	; Stack: dividend
	PUSH	HL	; Stack: dividend, modulus
	CALL	FDIV
	CALL	FINT	; integer ratio
	EX	DE,HL	; DE = int(BC/HL)
	POP	BC	; Stack: dividend; BC = modulus
	CALL	FMUL	; Stack: dividend
	EX	DE,HL
	POP	HL
	; continue with FSUB
